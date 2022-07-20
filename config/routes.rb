Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :user, :path => ''
  
  scope :admin do
    resources :uploads, except: :show
    resources :topics
    resources :uploadlinks
    resources :upload_category_links
    resources :categories
  end

  get "admin", to: "sessions#admin"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "/uploads/:id", to: "uploads#show"

  root to: "main#index"


end