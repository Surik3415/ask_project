Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sessions, only: %i[new create destroy]

  resources :users, only: %i[new create]

  resources :questions do
    resources :answers, except: %i[new show]
  end
  # get '/questions', to: 'questions#index'

  # get '/questions/new', to: 'questions#new'

  # post '/questions', to: 'questions#create'

  root 'pages#index'
end
