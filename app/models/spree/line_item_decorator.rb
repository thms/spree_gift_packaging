Spree::LineItem.class_eval do
  
  attr_accessible :gift_package_id
  
  belongs_to :gift_package
  
  # Updates each of the line item adjustments.  
  # Adjustments will check if they are still eligible. Ineligible adjustments are preserved but not counted
  # towards adjustment_total.
  def update_adjustments
    self.adjustments.reload.each { |adjustment| adjustment.update!(self) }
  end
  
  # Override the original call, to include updating line item's adjustments (specifically for gift packaging)
  # update_order is called after a line item is saved, so this is a great spot to recalculate the adjustments for this line_item
  def update_order
    # If there is no adjustment for the current gift package, just create one here unless there already is one for the gift package
    if self.gift_package_id && self.gift_package_id > 0 && self.adjustments.gift_packaging.where(:originator_id => self.gift_package_id).count == 0
      self.gift_package.adjust(self) 
    end 
    # Then update all adjustments
    self.update_adjustments
    # update the order totals, etc.
    order.update!
  end
  

  
end