Spree::Adjustment.class_eval do
  
  scope :gift_packaging, lambda { where(:originator_type => 'Spree::GiftPackage') }
  
end