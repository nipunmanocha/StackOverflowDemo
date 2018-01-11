Rails.application.routes.draw do
  # root to: 'static_pages#home'
  # resources :users
  # resources :questions
  # resources :answers
  # resources :votes

  concern :commentable { resources :comments, shallow: true }
  concern :voteable { resources :votes, shallow: true }

  concern :api_base do
    get 'signup', to: 'users#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    resources :users do
      resources :questions, shallow: true, concerns: [:commentable, :voteable] do
        resources :answers, shallow: true, concerns: [:commentable, :voteable]
      end
    end
  end

  namespace :v1 do
    concerns :api_base
  end
end
