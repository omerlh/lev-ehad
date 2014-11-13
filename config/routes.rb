LevEhad::Application.routes.draw do

  resource :volunteer
  resource :allocation_request

  get "/volunteer/all", to: "volunteers#show"

  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  
      
  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
    
  end
  
end
