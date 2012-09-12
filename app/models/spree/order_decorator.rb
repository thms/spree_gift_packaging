require 'spree/gift_package'
Spree::Order.class_eval do
  

  def gift_packaging_total
    amount = 0.0
    line_items.each do |line_item|
      amount += line_item.adjustments.eligible.gift_packaging.map(&:amount).sum
    end
    amount
  end
    
   
   # Overide update totals to include the gift packaging amount in the line items amount
   # TODO: how to present then to the user?
   # Updates the following Order total values:
   #
   # +payment_total+      The total value of all finalized Payments (NOTE: non-finalized Payments are excluded)
   # +item_total+         The total value of all LineItems
   # +adjustment_total+   The total value of all adjustments (promotions, credits, etc.)
   # +total+              The so-called "order total."  This is equivalent to +item_total+ plus +adjustment_total+.
   def update_totals
     # update_adjustments
     self.payment_total = payments.completed.map(&:amount).sum
     self.item_total = line_items.map(&:amount).sum
     
     self.adjustment_total = adjustments.eligible.map(&:amount).sum
     self.total = item_total + adjustment_total + gift_packaging_total
   end
   
   ## Overrride price adjustments to exclude the giftpackaging items
   # Array of adjustments that are inclusive in the variant price.  Useful for when prices
   # include tax (ex. VAT) and you need to record the tax amount separately.
   def price_adjustments
     adjustments = []

     line_items.each do |line_item|
       adjustments.concat (line_item.adjustments - line_item.adjustments.gift_packaging)
     end

     adjustments
   end
   
   ## Override add_variant to allow adding the gift package right away, iso of a separate update call later in the controller
   def add_variant_with_gift_package(variant, quantity = 1, gift_package_id = nil)
     current_item = contains?(variant)
     if current_item
       current_item.quantity += quantity
       current_item.gift_package_id = gift_package_id
       current_item.save
     else
       current_item = Spree::LineItem.new(:quantity => quantity)
       current_item.variant = variant
       current_item.price   = variant.price
       current_item.gift_package_id = gift_package_id
       self.line_items << current_item
     end

     # populate line_items attributes for additional_fields entries
     # that have populate => [:line_item]
     Spree::Variant.additional_fields.select { |f| !f[:populate].nil? && f[:populate].include?(:line_item) }.each do |field|
       value = ''

       if field[:only].nil? || field[:only].include?(:variant)
         value = variant.send(field[:name].gsub(' ', '_').downcase)
       elsif field[:only].include?(:product)
         value = variant.product.send(field[:name].gsub(' ', '_').downcase)
       end
       current_item.update_attribute(field[:name].gsub(' ', '_').downcase, value)
     end

     current_item
   end
   
   
  
  
end