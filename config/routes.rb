Rails.application.routes.draw do
  root 'publications#index'
  devise_for :users
  
  resources :publications
  resources :users, only:[:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
