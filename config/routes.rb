Rails.application.routes.draw do
  resources :snipps do
    get 'subscreens', on: :collection
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  post '/users/upload_avatar' => 'users#upload_avatar'
  get '/ui' => 'static#ui'
  get '/about' => 'static#about'

  get '/user_snipps' => 'snipps#user_snipps'
  get 'user_snipps/:user', to: 'snipps#user_snipps', as: :user

  get '/to_check' => 'snipps#unchecked'

  get '/set_public' => 'snipps#set_public'
  get '/set_public/:id', to: 'snipps#set_public'

  get '/to_verification' => 'snipps#to_verification'
  get '/to_verification/:id', to: 'snipps#to_verification'

  get '/tags' => 'snipps#tags'
  get 'tags/:tag', to: 'snipps#index', as: :tag

  get '/snipps/:id/like', to: 'snipps#like', as: :id

  root to: 'snipps#index'
end
