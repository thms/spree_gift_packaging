Spree::Core::Engine.routes.prepend do
  
  namespace :admin do
    
    resources :gift_packages
    
  end
  
end
