Rails.application.routes.draw do

  root to: "sessions#new"
  # get '/', to: "sessions#new"

  post '/location', to: "sessions#location"
  post '/formality', to: "outfits#formality"
  post '/custom_article', to: "outfits#custom_article"
  get '/article_options', to: "outfits#article_options"
  get '/outfits_all', to: "outfits#outfits_all"

  get '/analysis', to: "wardrobes#analysis" 

  get '/logout', to: "sessions#destroy"

  post '/login', to: "sessions#create"

  resources :users, except: [:destroy]

  resources :articles

  resources :outfits

  resources :wardrobes

  

  post '/articles/color', to: "articles#color"

end
