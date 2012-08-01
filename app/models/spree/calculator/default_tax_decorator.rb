# Override the default tax calulator to include the gift packaging in tha sales tax calculations
Spree::Calculator::DefaultTax.class_eval do

  private


  def compute_order(order)
    Rails.logger.warn "===== calc tax for order ======"
    matched_line_items = order.line_items.select do |line_item|
      line_item.product.tax_category == rate.tax_category
    end

    line_items_total = matched_line_items.sum(&:total) + order.gift_packaging_total
    round_to_two_places(line_items_total * rate.amount)
  end

  def compute_line_item(line_item)
    Rails.logger.warn "===== calc tax for line item ======"
    if line_item.product.tax_category == rate.tax_category
      deduced_total_by_rate(line_item.total + line_item.adjustments.eligible.gift_packaging.map(:preferred_amount).sum, rate)
    else
      0
    end
  end

end
