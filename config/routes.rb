Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :publications
  resources :users, only: [:show]
  resources :books
  resources :posts do
    resources :comments
    resources :goods, only: [:create, :destroy]
    collection do
      post :confirm
      get :get_image
    end
  end
end
