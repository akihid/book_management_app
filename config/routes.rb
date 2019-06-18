Rails.application.routes.draw do
  
  root 'publications#index'
  devise_for :users
  
  resources :publications
  resources :users, only:[:show]
  resources :books
  resources :posts do
    collection do
      post :confirm
    end
  end
end
