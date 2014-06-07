Rails.application.routes.draw do
  resources :snipps

  devise_for :users
  get '/ui' => 'static#ui'
  root to: 'static#start'
end
