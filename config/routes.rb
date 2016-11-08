Rails.application.routes.draw do
  root 'home#index'
  
  resources :users do
    member do
      get 'profile'
      get 'matches'
    end  
  end
  
  #For the session destroy action we'll add a regular delete request to the sessions destroy action.
  get 'auth/:provider/callback', to: 'sessions#create'
  match 'sign_out', to: 'sessions#destroy', via: :delete  
  
end
