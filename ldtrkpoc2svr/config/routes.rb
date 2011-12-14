Ldtrkpoc2svr::Application.routes.draw do
  resources :posts do
    resources :authors
  end
  
  resources :topics do
    resources :posts
  end

  resources :users
  
  resources :authors, :controller => 'users'
  resources :administrators, :controller => 'users'
  
  
  get "home/index"

  root :to => 'home#index'
end
