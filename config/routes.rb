Rails.application.routes.draw do
  root 'users#index'
  resources :users do
    collection do
      get :data_actions
      get :sort_user
      get :status
    end
  end
  get '/users/data_actions', to: 'users#data_actions'
  get '/users/sort_user', to: 'users#sort_user'
  get '/users/status', to: 'users#status'

end
