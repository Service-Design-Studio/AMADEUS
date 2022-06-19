Rails.application.routes.draw do
  # get 'upload_file/upload'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope :admin do
    resources :articles, only: [:index, :update]
  end

  # root :to => redirect('/admin/articles')

  # root to: "uploads#index"

  get "admin", to: "sessions#admin"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  root to: "main#index"


end
