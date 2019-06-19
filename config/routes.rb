Rails.application.routes.draw do
  root 'publications#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :publications
  resources :users, only: [:show]
  resources :books
  resources :goods, only: [:create, :destroy]
  resources :posts do
    resources :comments
    collection do
      post :confirm
    end
  end
end
