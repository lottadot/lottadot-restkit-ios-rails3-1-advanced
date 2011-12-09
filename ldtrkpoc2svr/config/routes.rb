Ldtrkpoc2svr::Application.routes.draw do
  resources :topics

  resources :posts

  resources :users

  get "home/index"

  root :to => 'home#index'
end
