Rails.application.routes.draw do

  namespace :dashboard do
    resources :cards
    resources :decks
    post 'check_card' => 'cards#check_card'
    post 'active_deck' => 'decks#active_deck'
  end

  namespace :home do
    resources :users
    resources :user_sessions, only: [:new, :create, :destroy]
    get 'login' => 'user_sessions#new', :as => :login
    post 'logout' => 'user_sessions#destroy', :as => :logout
    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback"
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  end

  root 'home/welcome#index'
end
