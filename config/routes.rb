Rails.application.routes.draw do
  post '/signup', to: 'users#signup'
  post '/login', to: 'users#login'

  post '/book', to: 'books#create'
end
