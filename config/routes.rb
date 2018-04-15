Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'users#create', as: :create_user
  resource :calendar, only: %i[show]
  root to: 'users#new'
end
