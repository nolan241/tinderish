Rails.application.routes.draw do
  root 'home#index'
  
  get 'home/index'
  get 'users/index'
  get 'users/edit'
  get 'users/profile'
  get 'users/matches'
end
