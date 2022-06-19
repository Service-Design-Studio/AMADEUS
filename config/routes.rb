Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :uploads

  scope :admin do
    resources :articles, only: [:index, :update]
  end

  root :to => redirect('/admin/articles')

end
