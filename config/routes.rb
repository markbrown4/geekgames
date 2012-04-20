GeekGames::Application.routes.draw do

  get "prizes" => 'prizes#index'
  get "leaderboard" => 'leaderboard#index'

  #resources "scores"
  
  get "rounds/start" => "rounds#start", :as => 'start_round'
  get "rounds/play" => "rounds#play", :as => 'play_game'
  get "rounds" => "rounds#index", :as => 'rounds'
  
  devise_for :users
  
  get 'home' => "home#index", :as => 'home'
  
  root :to => "home#index"
  
end
