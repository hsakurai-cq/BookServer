Rails.application.routes.draw do
  post '/sign_up', to: 'users#signup'
  post '/login', to: 'users#login'

  resources :books, :only => [:index, :create, :update]
end
