GeekGames::Application.routes.draw do

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'
  
  namespace :admin do
    get '/' => "dashboard#index"
    get 'dashboard' => "dashboard#index"
    resources :pages
    resources :users
    resources :games
    resources :deals do
      resources :prizes
    end
  end

  get  "leaderboard" => 'leaderboard#index'

  get  "profile" => "profile#edit", :as => :profile
  put  "profile" => "profile#update"

  get  "win"  => "rounds#win", :as => :win
  post "games/submit" => "games#submit"
  get  "games"        => "games#index", :as => :games

  get ":slug" => "pages#show", :as => :page

  root :to => "home#index", :as => :home

end
