module Spree
  module GiftPackagesHelper

    def selector_title
      image_tag self.image(:mini) + " #{self.title} (#{number_to_currency(self.price)} per bottle)"
    end
    
    # converts line breaks in gift package description into <p> tags (for html display purposes)
    def gift_package_description(gift_package)
      raw(gift_package.description.gsub(/^(.*)$/, '<p>\1</p>'))
    end
    
  end
end
