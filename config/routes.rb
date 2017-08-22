Rails.application.routes.draw do
  post '/signup', to: 'users#signup'
  post '/login', to: 'users#login'

  get '/books', to: 'books#index'
  post '/book', to: 'books#create'
  put '/book/:id', to: 'books#update'
end
