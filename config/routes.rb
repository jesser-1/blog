Rails.application.routes.draw do
  

  devise_for :users
  root to: "articles#index"
  devise_for :installs
  resources :articles do
    resources :comments
  end
  namespace :api, defaults: {format: :json} do
    post "sign_in", to: "sessions#index"
    resources :articles do
      resources :comments
    end
  end

end
