Rails.application.routes.draw do
  resources :snipps do
    get 'subscreens', :on => :collection
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  post '/users/upload_avatar' => 'users#upload_avatar'
  get '/ui' => 'static#ui'

  get '/user_snipps' => 'snipps#user_snipps'
  get 'user_snipps/:user', to: 'snipps#user_snipps', as: :user

  get '/tags' => 'snipps#tags'
  get 'tags/:tag', to: 'snipps#index', as: :tag

  root to: 'snipps#index'
end
