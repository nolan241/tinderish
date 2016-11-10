Rails.application.routes.draw do
  root 'home#index'
  
  resources :users do
    member do
      get 'profile'
      get 'matches'
    end  
  end
  
  #Omniauth sign in and out 
  #session create action we'll add a facebook callback route
  get 'auth/:provider/callback', to: 'sessions#create'
  #For the session destroy action we'll add a regular delete request to the sessions destroy action.
  match 'sign_out', to: 'sessions#destroy', via: :delete  
  
end
