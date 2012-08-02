Spree::Adjustment.class_eval do
  
  ## before; only one per order, now we have one per line item
  ##scope :gift_packaging, lambda { where(:originator_type => 'Spree::GiftPackage') }
  scope :gift_packaging, lambda { where(:originator_type => 'Spree::GiftPackage', :adjustable_type => 'Spree::LineItem') }
  
end