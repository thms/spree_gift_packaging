require 'spree/gift_package'
Spree::Order.class_eval do
  

  def gift_packaging_total
    amount = 0.0
    line_items.each do |line_item|
      amount += line_item.adjustments.eligible.gift_packaging.map(&:amount).sum
    end
    amount
  end
  
  # Creates new gift packaging charges for line items that use gift packaging
  # This is called in the current_order_decorator.after_save_new_order 
  # Deprecated, wrong model (charge per order), do not use
  def create_gift_packaging_charge!

    # creates an adjustment for each matching gift package. 
    # there should be only one that matches an order (and actually they are matched on the line items anyway)
    # TODO: Check if this is correct
    Spree::GiftPackage.match(self).each { |package| package.adjust(self) }
    
  end
  
   
   # Overide upatate totals to include the gift packaging amount in the line items amount
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
   
  
  
end