Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # scope :users do
  #   post :signup, to: 'users#signup'
  # end
  post '/signup', to: 'users#signup'
end
