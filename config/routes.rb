Rails.application.routes.draw do
  get 'static_pages/post'

  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'
  get 'post' => 'static_pages#post'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy, :show, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :comments
end
