Rails.application.routes.draw do
  root 'home#index'
  
  resources :users do
    member do
      get 'profile'
      get 'matches'
  end
end
