# Caclulates gift packaging cost for the order
# Basic computation per line item: qty * preferred_amount if line_item.gift_packaging_id != nil
# For order: sum of above
module Spree
  class Calculator::GiftPackaging < Spree::Calculator
    
    preference :amount, :decimal, :default => 0.0
    
    def self.description
      I18n.t(:gift_packaging)
    end

    def compute(computable)
      case computable
        when Spree::Order
          Rails.logger.warn "======= compute order ======= should not be called here, line item level only otherwise uses wrong caclulator"
          compute_order(computable)
        when Spree::LineItem
          Rails.logger.warn "======= compute line item #{computable.id} ======="
          compute_line_item(computable)
      end
    end


    private

      def gift_package
        gift_package = self.calculable
      end

      def compute_order(order)
        amount = 0.0
        order.line_items.each do |line_item|
          amount += compute_line_item(line_item)
        end
        amount
      end

      def compute_line_item(line_item)
        if line_item.gift_package && line_item.gift_package_id == self.calculable.id
          Rails.logger.warn "Line Item gift package: #{line_item.gift_package.id}"
          Rails.logger.warn "selff gift package: #{self.calculable.id}"
          Rails.logger.warn "selff preferred amount: #{self.preferred_amount}"
          return line_item.quantity * self.preferred_amount
        else
          return 0
        end
      end

  end
end
