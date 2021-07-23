Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  post 'new_follow', to: 'artists#new_follow'
  get 'dashboard', to: 'dashboards#show'
  post 'spotify_to_dashboard', to: 'dashboards#spotify_to_dashboard'
  get 'feed', to: 'feeds#show'
  get '/auth/spotify/callback', to: 'users#spotify'
  post 'add_from_spotify', to: 'artists#add_from_spotify'
  post 'add_dismissed_to_user', to: 'users#dismissed'
  resources :artists, only: [ :index, :create ] do
    member do
      post 'toggle_follow', to: 'artists#toggle_follow'
    end
  end
  get '/user' => "welcome#index", :as => :user_root
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
