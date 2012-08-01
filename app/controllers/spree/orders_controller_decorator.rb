Spree::OrdersController.class_eval do

  # Override method to allow adding of gift packaging from the various cart forms
  
  # Adds a new item to the order (creating a new order if none already exists)
  #
  # Parameters can be passed using the following possible parameter configurations:
  #
  # * Single variant/quantity pairing
  # +:variants => {variant_id => quantity}+
  #
  # * Multiple products at once
  # +:products => {product_id => variant_id, product_id => variant_id}, :quantity => quantity +
  # +:products => {product_id => variant_id, product_id => variant_id}}, :quantity => {variant_id => quantity, variant_id => quantity}+
  def populate
    @order = current_order(true)

    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
      quantity = params[:quantity][variant_id.to_i].to_i if params[:quantity].is_a?(Hash)
      @variant = Spree::Variant.find(variant_id)
      line_item = @order.add_variant(@variant, quantity) if quantity > 0
      if params[:gift_packages] && params[:gift_packages][product_id].to_i > 0
        line_item.update_attribute(:gift_package_id, params[:gift_packages][product_id])
      else
        line_item.update_attribute(:gift_package_id, Spree::Product.find(product_id).default_gift_package.id)
      end
    end if params[:products]

    params[:variants].each do |variant_id, quantity|
      Rails.logger.warn "================ orders controller.populate adding variant to order============"
      Rails.logger.warn params[:gift_packages].inspect
      quantity = quantity.to_i
      @variant = Spree::Variant.find(variant_id)
      line_item = @order.add_variant(@variant, quantity) if quantity > 0
      if params[:gift_packages] && params[:gift_packages][variant_id].to_i > 0
        line_item.update_attribute(:gift_package_id, params[:gift_packages][variant_id])
      else
        line_item.update_attribute(:gift_package_id, @variant.product.default_gift_package.id)
      end
    end if params[:variants]

    fire_event('spree.cart.add')
    fire_event('spree.order.contents_changed')
    respond_with(@order) { |format| format.html { redirect_to cart_path } }
  end
end