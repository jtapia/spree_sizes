Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :sizes
  end
end
