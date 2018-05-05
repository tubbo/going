Rails.application.routes.draw do
  resource :calendar, only: %i[show]

  get '/auth/:provider/callback', to: 'users#create', as: :create_user
  get '/:id', to: 'high_voltage/pages#show'

  root to: 'users#new'
end
