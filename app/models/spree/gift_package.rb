module Spree
  class GiftPackage < ActiveRecord::Base
    
    calculated_adjustments
    
    validates_presence_of :title
    validates_presence_of :description
    
    has_attached_file :image,
                      :styles => { :mini => '48x48>', :midi => '100x100', :thumb => '240x240>' },
                      :default_style => :thumb,
                      :url => "/system/gift_packages/:attachment/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/system/gift_packages/:attachment/:id/:style/:basename.:extension"
    
    # Called on order.update!
    def eligible?(order)
      true
    end
    
    # Create adjustments for the order
    def adjust(order)
      label = "Gift Packaging"
      # Create a single adjustment for the order covering all line items that use gift packaging
      if order.is_a?(Spree::Order)
        create_adjustment(label, order, order)
      end
    end
    
    def self.match(order)
      Spree::GiftPackage.all
    end
    
    def price
      self.calculator.preferred_amount
    end
    
  end
end