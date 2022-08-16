Rails.application.routes.draw do

  # sidekiq UI
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :user, :path => ''
  
  scope :admin do
    resources :uploads, except: :show
    resources :tags
    resources :categories

    resources :upload_tag_links, only: %i[ update, destroy, edit ]
    resources :upload_category_links, only: %i[ update, destroy, edit ]
  end

  resources :upload_tag_links, except: %i[ update, destroy, edit ]
  resources :upload_category_links, except: %i[ update, destroy, edit ]

  get "admin", to: "sessions#admin"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "/uploads/:id", to: "uploads#show"

  root to: "main#index"


end