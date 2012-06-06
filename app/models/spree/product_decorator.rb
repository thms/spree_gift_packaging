Spree::Product.class_eval do
  
  # Provide all possible gift packages for a product
  # Currently all packages (only one anyway) are available for all products
  # Hook in here to make restrictions and limitations.
  def possible_gift_packages
    Spree::GiftPackage.all
  end
end