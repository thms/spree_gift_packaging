module Spree
  module GiftPackagesHelper

    def selector_title
      image_tag self.image(:mini) + " #{self.title} (#{number_to_currency(self.price)} per bottle)"
    end
    
  end
end
