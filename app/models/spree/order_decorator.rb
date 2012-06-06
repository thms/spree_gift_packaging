require 'spree/gift_package'
Spree::Order.class_eval do
  
  def gift_packaging_total
    adjustments.gift_packaging.map(&:amount).sum
  end
    
  # Creates new gift packaging charges for line items that use gift packaging
  # how to make this being called  - in self.activate register_update_hook
  # But that seems to crate an endless loop
  def create_gift_packaging_charge!
    # destroy any previous adjustments (eveything is recalculated from scratch)
    adjustments.gift_packaging.each { |e| e.destroy }

    # creates an adjustment for each matching gift package. 
    # there should be only one that matches an order (and actually they are matched on the line items anyway)
    Spree::GiftPackage.match(self).each { |package| package.adjust(self) }
  end
  
  # Create one gift charge after the creation, that will get updated every time the order gets updated.
  after_create :create_gift_packaging_charge!
  
  
  
end