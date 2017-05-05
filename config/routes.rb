Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :listings do
    resources :reservations, only: [:create, :destroy, :update, :show]
  end 

  resources :reservations, only: [:index]

  get '/reservations/:rid/braintree/new' => "braintree#new", as: "payment_new"
  post '/reservations/:rid/braintree/checkout' => "braintree#checkout", as: "payment_checkout"

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  
  get "/users/:id/edit" => "users#edit", as: "edit_user"

  root 'static#home'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # constraints Clearance::Constraints::SignedIn.new do
  #   root to: "users#show", as: :signed_in_root
  # end

  # constraints Clearance::Constraints::SignedOut.new do
  # 	root to: 'static#home'
  # end


end
