Symposium::Application.routes.draw do
  devise_for :users

  root to: "forums#show", id: 1

  resources :users 

  resources :forums do
    resources :topics
  end

  resources :topics do
    resources :posts
  end

end
