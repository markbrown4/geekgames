GeekGames::Application.routes.draw do

  devise_for :users

  # resources :authentications
  # match '/auth/:provider/callback' => 'authentications#create'
  
  get  "prizes" => 'prizes#index'
  get  "leaderboard" => 'leaderboard#index'

  #resources "scores"
  
  get  "profile" => "profile#edit", :as => :profile
  put  "profile" => "profile#update"
  
  get  "rounds/start" => "rounds#start", :as => 'start_round'
  get  "rounds/play" => "rounds#play", :as => 'play_game'
  post "rounds/submit" => "rounds#submit", :as => 'score_submission'
  get  "rounds" => "rounds#index", :as => 'rounds'

  get  'home' => "home#index", :as => 'home'
  root :to => "home#index"
  
end
