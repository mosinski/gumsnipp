Rails.application.routes.draw do
  resources :snipps do
    get 'subscreens', :on => :collection
  end

  devise_for :users
  get '/ui' => 'static#ui'
  get '/tags' => 'snipps#tags'
  get 'tags/:tag', to: 'snipps#index', as: :tag
  root to: 'snipps#index'
end
