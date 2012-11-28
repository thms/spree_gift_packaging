Spree::OrdersController.class_eval do

  respond_to :js, :only => [:populate, :update, :change_gift_package]

  ssl_allowed :populate, :update, :change_gift_package

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
  # Adds default gift package if there is not inforamtion present about gift packages
  def populate
    @order = current_order(true)

    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
      quantity = params[:quantity][variant_id.to_i].to_i if params[:quantity].is_a?(Hash)
      @variant = Spree::Variant.find(variant_id)
      if params[:gift_packages] && params[:gift_packages][product_id].to_i > 0
        gift_package_id = params[:gift_packages][product_id]
      elsif params[:gift_packages] && params[:gift_packages][product_id].to_i == 0
        gift_package_id = 0
      else
        gift_package_id = Spree::Product.find(product_id).default_gift_package.id
      end
      line_item = @order.add_variant_with_gift_package(@variant, quantity, gift_package_id) if quantity > 0
     end if params[:products]

    params[:variants].each do |variant_id, quantity|
      quantity = quantity.to_i
      @variant = Spree::Variant.find(variant_id)
      if params[:gift_packages] && params[:gift_packages][variant_id].to_i > 0
        gift_package_id = params[:gift_packages][variant_id]
      elsif params[:gift_packages] && params[:gift_packages][variant_id].to_i == 0
        gift_package_id = 0
      else
        gift_package_id = @variant.product.default_gift_package.id
      end
      line_item = @order.add_variant_with_gift_package(@variant, quantity, gift_package_id) if quantity > 0
    end if params[:variants]
    
    # get the source of add to cart - if we come from a tile, we want to show the gift packging selector, if we come from a product, we do not want to show it
    @source = params[:source]
    fire_event('spree.cart.add')
    fire_event('spree.order.contents_changed')
    respond_with(@order, @source) { |format| format.html { redirect_to cart_path } }
  end
  
  # allow setting the gift packaging for an item in the cart
  # get the product id and the gift package id, looks up the line item and sets the giftpackage for that.
  def change_gift_package
    @order = current_order(false)
    @product = Spree::Product.find(params[:product_id])
    line_item = @order.line_items.where(:variant_id => @product.master.id).first
    if params[:gift_package_id] == "0"
      line_item.update_attribute(:gift_package_id, 0)
    else
      @gift_package = Spree::GiftPackage.find(params[:gift_package_id])
      line_item.update_attribute(:gift_package_id, @gift_package.id)
    end
    fire_event('spree.order.contents_changed')
    respond_with(@order)
  end
  

end
