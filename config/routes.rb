Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :user, :path => ''

  scope :admin do
    resources :uploads
    resources :topics
    resources :uploadlinks
    resources :categories
    resources :upload_category_links
  end

  get "admin", to: "sessions#admin"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  root to: "main#index"
end