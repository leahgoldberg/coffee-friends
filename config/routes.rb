Rails.application.routes.draw do

  root 'users#new'

  get '/cafes/profile' => 'cafes#show'
  post '/cafes/borough' => 'cafes#borough'
  post '/cafes/neighborhood' => 'cafes#neighborhood'
  post '/coffee_gifts/filter' => 'coffee_gifts#filter'

  resources :cafes, only: [:index, :show, :update] do
    resources :coffee_gifts, only: [:new, :create]
  end

  resources :menu_items, only: [:destroy, :create, :update]
  resources :coffee_gifts, only: [:update]
  resources :transactions, only: [:new, :create]

  resources :users, only: [:create, :edit, :update]

  get '/register' => 'users#new'
  get '/auth/:provider/callback' => 'users#authenticate'

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/profile' => 'users#show'

  get '/confirmation/:id' => 'coffee_gifts#confirm', as: "confirmation"
  get '/redeem/:redemption_code' => 'coffee_gifts#show',  as: "redeem"
  put '/redeem/:redemption_code' => 'coffee_gifts#update'
  get '/confirm-redemption' => 'coffee_gifts#confirm_redemption', as: "confirm_redemption"
end
