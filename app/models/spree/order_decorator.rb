require 'spree/gift_package'
Spree::Order.class_eval do
  

  def gift_packaging_total
    ##adjustments.gift_packaging.map(&:amount).sum
    amount = 0.0
    line_items.each do |line_item|
      amount += line_item.adjustments.eligible.gift_packaging.map(&:amount).sum
    end
    amount
  end
  
  # Creates new gift packaging charges for line items that use gift packaging
  # This is called in the current_order_decorator.after_save_new_order 
  def create_gift_packaging_charge!

    # creates an adjustment for each matching gift package. 
    # there should be only one that matches an order (and actually they are matched on the line items anyway)
    # TODO: Check if this is correct
    Spree::GiftPackage.match(self).each { |package| package.adjust(self) }
    
  end
  
   
  
  
end