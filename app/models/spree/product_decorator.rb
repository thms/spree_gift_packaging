Spree::Product.class_eval do
  
  has_many :gift_package_exceptions
  
  # Provide all possible gift packages for a product
  # remove the ones that are not valid for the current product
  def possible_gift_packages
    Spree::GiftPackage.all.select { |gift_package| gift_package.valid_for_product?(self)  }
  end
end

