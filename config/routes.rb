Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root :to => redirect('/admin/articles')
  # root to: "uploads#index"


  devise_for :user, :path => '' #, :path_names => { :sign_out => "logout"}

  scope :admin do
    # resources :articles, only: [:index, :update]
    resources :uploads
    resources :posts
    resources :tags
    resources :topics
  end

  get "admin", to: "sessions#admin"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  root to: "main#index"
  


end