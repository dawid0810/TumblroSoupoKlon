Rails.application.routes.draw do
  get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
  get "hashtags",            to: "hashtags#index",     as: :hashtags

  devise_for :users

  resources :posts

  get '/repost/:id', to: 'posts#repost'
  get '/quick_repost/:id', to: 'posts#quick_repost'
  get '/user/:username', to: 'users#show'
  get '/user/:username/post/:id', to: 'posts#show'
  get '/everyone', to: "posts#index"
  get '/followers', to: "users#followers"
  get '/followed', to: "users#followed"
  get '/user/:username/followed', to: 'users#followed'
  get '/user/:username/followers', to: 'users#followers'
  get '/follow/:id', to: 'users#follow'
  get '/unfollow/:id', to: 'users#unfollow'
  root 'posts#index'
end
