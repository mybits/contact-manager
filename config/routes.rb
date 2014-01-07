ContactManager::Application.routes.draw do
  resources :companies
  resources :email_addresses, except: [:index, :show]
  resources :phone_numbers, except: [:index, :show]
  resources :people
  get '/auth/:provider/callback' => 'sessions#create'
  resource :sessions, :only => [:create]

end
