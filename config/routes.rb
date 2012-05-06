GeekGames::Application.routes.draw do

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  namespace :admin do
    get '/' => "dashboard#index"
    get 'dashboard' => "dashboard#index"
    resources :pages
    resources :users
  end

  get  "prizes" => 'prizes#index'

  get  "leaderboard" => 'leaderboard#index'

  get  "profile" => "profile#edit", :as => :profile
  put  "profile" => "profile#update"

  get  "games/start"  => "games#start", :as => 'start_round'
  get  "games/play"   => "games#play", :as => 'play_game'
  post "games/submit" => "games#submit", :as => 'score_submission'
  get  "games"        => "games#index", :as => 'games'

  get  'home' => "home#index", :as => 'home'

  get ":slug" => "pages#show", :as => :page

  root :to => "home#index"

end
