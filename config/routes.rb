Rails.application.routes.draw do
  root to: redirect('/items')
  devise_for :users
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sales do
      resources :charges
  end
end
