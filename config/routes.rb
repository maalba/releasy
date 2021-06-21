Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  post 'new_follow', to: 'artists#new_follow'
  get 'dashboard', to: 'dashboards#show'
  get 'feed', to: 'feeds#show'
  get '/auth/spotify/callback', to: 'users#spotify'
  post 'add_from_spotify', to: 'artists#add_from_spotify'
  resources :artists, only: [ :index, :create ] do
    member do
      post 'toggle_follow', to: 'artists#toggle_follow'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
