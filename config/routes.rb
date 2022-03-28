Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/', to: 'home#index'

  namespace :api do
    namespace :v1 do
      # /api/v1

      post '/users', to: 'users#create'
      get '/users/:id', to: 'users#show'

      resources :validation_codes, only:[:create]
      resource :session, only:[:create, :destroy]
      resource :me, only:[:show]
      resources :items
      resources :tags
      get '/items/search/:keyword', to: 'items#search'
    end
  end
  
end
