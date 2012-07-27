Spree::Core::Engine.routes.prepend do
  
  namespace :admin do
    
    resources :gift_packages
    resources :gift_package_exceptions
  end
  
end
