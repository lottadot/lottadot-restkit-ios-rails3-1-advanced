Ldtrkpoc2svr::Application.routes.draw do
  resources :posts

  resources :topics

  resources :users

  get "home/index"

  root :to => 'home#index'
end
