require 'spree/gift_package'
Spree::Order.class_eval do
  

  def gift_packaging_total
    adjustments.gift_packaging.map(&:amount).sum
  end
  
  # Creates new gift packaging charges for line items that use gift packaging
  # This is called in the current_order_decorator.after_save_new_order 
  def create_gift_packaging_charge!

    # creates an adjustment for each matching gift package. 
    # there should be only one that matches an order (and actually they are matched on the line items anyway)
    Spree::GiftPackage.match(self).each { |package| package.adjust(self) }
    
  end
  
   
  
  
end