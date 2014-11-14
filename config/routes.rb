LevEhad::Application.routes.draw do

  get 'allocation_approval/index'

  get 'statistics/show'
  get "statistics/sum_volunteers", to: "statistics#sum_volunteers"

  resource :volunteer
  resource :allocation_request

  get "/volunteer/all", to: "volunteers#show"
  get "/volunteer_availability/getVolunteers", to: "volunteer_availability#available_volunteers"
  get "/volunteer_availability/freeVolunteers", to: "volunteer_availability#free_volunteers"


  get 'allocation/index'
  get 'allocation/available_volunteers'
  get 'allocation_approval/available_volunteers'
  get 'allocation/hamals_status'
  post 'allocation/dealloc_volunteer'
  post 'allocation/allocate_volunteer'
  post 'allocation_approval/deny_volunteer'
  post 'allocation_approval/approve_volunteer'

  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"

  authenticate :user, lambda { |u| u.admin? } do
    mount Upmin::Engine => '/admin'
  end

  devise_for :users
  namespace :admin do
    root "base#index"
    resources :users
  end
end
