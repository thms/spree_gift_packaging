Spree::Core::CurrentOrder.module_eval do

  # This overrides the method as defined in spree_auth, so that we can create the gift_packaging_charge here
  def after_save_new_order
    # create the initial gift packaging charge for the order
    ## TODO remove - should not be needed here, should be create on the line item level, whenenver a line item has a gift package charge
    ## @current_order.create_gift_packaging_charge!
    
    # make sure the user has permission to access the order (if they are a guest)
    return if current_user
    session[:access_token] = @current_order.token
  end
  
end
