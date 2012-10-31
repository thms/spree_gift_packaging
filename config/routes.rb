Spree::Core::Engine.routes.prepend do
  
  match '/orders/change_gift_package', :to => 'orders#change_gift_package', :via => :post
  
  namespace :admin do
    
    resources :gift_packages
    resources :gift_package_exceptions
  end
  
end
