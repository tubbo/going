Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'users#create'
  resource :calendar, only: %i[show]
  root to: 'users#new'
end
