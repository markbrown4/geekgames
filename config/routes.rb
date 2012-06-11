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
  end

  get  "prizes" => 'prizes#index'

  get  "leaderboard" => 'leaderboard#index'

  get  "profile" => "profile#edit", :as => :profile
  put  "profile" => "profile#update"

  post "games/submit" => "games#submit", :as => 'score_submission'
  get  "games"        => "games#index", :as => 'games'

  get  'home' => "home#index", :as => 'home'

  get ":slug" => "pages#show", :as => :page

  root :to => "home#index"

end
