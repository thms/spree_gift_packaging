Spree::Product.class_eval do
  
  has_many :gift_package_exceptions
  
  # Provide all possible gift packages for a product
  # remove the ones that are not valid for the current product (due to exceptions)
  def possible_gift_packages
    Spree::GiftPackage.all.select { |gift_package| gift_package.valid_for_product?(self)  }
  end
  
  # Returns the default gift package for a product
  def default_gift_package
    # ToDo: make depend on the product itself.
    gift_packages = Spree::GiftPackage.arel_table
    Spree::GiftPackage.where(gift_packages[:title].matches("%suede%")).first
  end
end

