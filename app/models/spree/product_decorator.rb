Spree::Product.class_eval do
  
  has_many :gift_package_exceptions
  
  # Provide all possible gift packages for a product
  # remove the ones that are not valid for the current product (due to admin defined exceptions)
  def possible_gift_packages
    Spree::GiftPackage.all.select { |gift_package| gift_package.valid_for_product?(self)  }
  end
  
  # Returns the default gift package for a product
  # If the product does not have any gift packages, it should return the no gift package
  # If the product does not have the global gift package enabled, it should use no gift package
  def default_gift_package
    # ToDo: make depend on the product itself.
    # check if the product is setup without gift packages
    if self.possible_gift_packages.count == 0
      gift_package = Spree::DummyGiftPackage.new('No Gift Packaging')
    else
      gift_packages = Spree::GiftPackage.arel_table
      global_default_gift_package = Spree::GiftPackage.where(:is_default => true).first
      if self.possible_gift_packages.include?(global_default_gift_package)
        gift_package =  global_default_gift_package
      else
        gift_package =  Spree::DummyGiftPackage.new('No Gift Packaging')
      end
    end
    gift_package
  end
end
