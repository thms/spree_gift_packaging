module Spree
  class GiftPackage < ActiveRecord::Base
    include ActionView::Helpers::NumberHelper
    
    calculated_adjustments
    
    validates_presence_of :title
    validates_presence_of :description
    
    has_attached_file :image,
                      :styles => { :mini => '48x48>', :midi => '100x100', :thumb => '240x240>' },
                      :default_style => :thumb,
                      :url => "/system/gift_packages/:attachment/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/system/gift_packages/:attachment/:id/:style/:basename.:extension"
    
    has_many :gift_package_exceptions
    
    # Should be called on order.update for line items and order, but is not when I change the gift package ID
    # Is it called when qty changes? no
    def eligible?(object)
      Rails.logger.warn "============== #{object.class.name} =============="
      object.gift_package_id == self.id
    end
    
    # Create adjustments for the line item
    # TODO: this should be done and called on the line item level, not on the order level, since each line item
    # can have a different gift package
    def adjust(object)
      label = "Gift Packaging"
      # Create a single adjustment for the order covering all line items that use gift packaging (WRONG)
      if object.is_a?(Spree::Order)
        Rails.logger.warn "========= create adjustment for order, should never happen ======="
        create_adjustment(label, object, object, true)
      end
      if object.is_a?(Spree::LineItem)
        Rails.logger.warn "============= create adjustment for line item, OK ========="
        create_adjustment(label, object, object, false)
      end
    end
    
    # TODO: Do we need to change this to the specific package?
    def self.match(order)
      Rails.logger.warn "======== giftpackage.match #{order.class.name} ========"
      Spree::GiftPackage.all
    end
    
    def price
      self.calculator.preferred_amount
    end
    
    def valid_for_product?(product)
      gift_package_exceptions.each do |exception|
        return false if exception.covers?(product) 
      end
      true
    end
    
    # true of the gift package is the default for the product
    # Todo: use prodcut dependent defaults
    def default_for_product?(product)
      self.title.downcase.include?('suede')
    end
    
    def title_for_selector
      "#{self.title} (#{number_to_currency(self.price)} per bottle)"
    end
    
    
  end
end