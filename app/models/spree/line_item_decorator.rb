Spree::LineItem.class_eval do
  
  attr_accessible :gift_package_id
  
  belongs_to :gift_package

  
end