Ldtrkpoc2svr::Application.routes.draw do
  resources :posts

  resources :topics

  resources :users
  
  resources :authors, :controller => 'users'
  resources :administrators, :controller => 'users'
  
  
  get "home/index"

  root :to => 'home#index'
end
