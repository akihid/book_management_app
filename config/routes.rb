Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :publications
  resources :users, only: %i[show] do
    resources :books, only: %i[new create edit update destroy]
  end
  resources :posts do
    resources :comments, only: %i[create destroy]
    resources :goods, only: %i[create destroy]
    collection do
      post :confirm
      get :book_image
    end
  end
end
