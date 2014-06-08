Rails.application.routes.draw do
  resources :snipps do
    get 'subscreens', :on => :collection
  end

  devise_for :users
  get '/ui' => 'static#ui'
  root to: 'snipps#index'
end
