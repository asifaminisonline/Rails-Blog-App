Rails.application.routes.draw do
  root to: 'users#index'

  get 'posts/new', to: 'posts#new'
  post 'posts', to: 'posts#create'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create, :new]
      resources :likes, only: [:create]
    end
  end

  post 'likes/:post_id', to: 'likes#create'
  post 'comments/:post_id', to: 'comments#create'
end
