# Caclulates gift packaging cost for the order
# Basic computation per line item: qty * preferred_amount if line_item.use_gift_packaging == true
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
          compute_order(computable)
        when Spree::LineItem
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
        if line_item.use_gift_packaging
          return line_item.quantity * self.preferred_amount
        else
          return 0
        end
      end

  end
end
