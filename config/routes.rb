Rails.application.routes.draw do

  root to: "sessions#new"
  # get '/', to: "sessions#new"

  get '/wardrobe_categories', to: "wardrobes#wardrobe_categories"

  post '/custom_category', to: "wardrobes#custom_category"

  post '/location', to: "sessions#location"
  post '/formality', to: "outfits#formality"
  post '/custom_article', to: "outfits#custom_article"
  get '/article_options', to: "outfits#article_options"
  get '/outfits_all', to: "outfits#outfits_all"
  post '/outfits_like', to: "outfits#outfits_like"
  post '/outfits_dislike', to: "outfits#outfits_dislike"

  get '/analysis', to: "wardrobes#analysis"

  get '/logout', to: "sessions#destroy"

  post '/login', to: "sessions#create"

  resources :users, except: [:destroy]

  resources :articles

  resources :outfits

  resources :wardrobes



  post '/articles/color', to: "articles#color"

end
