# Normally all gift packages are available for all products.
# This class defines expections to that rule, so if a gift_package - product combination is in this table, the gift package is not available '
# for this product
module Spree
  class GiftPackageException < ActiveRecord::Base
    
    belongs_to :gift_package
    belongs_to :product
    validates_presence_of :product_id
    validates_presence_of :gift_package_id
    
    def covers?(product)
      product == self.product
    end
    
    
  end
end