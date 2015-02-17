Rails.application.routes.draw do
  root to: "pages#home"

  get "about", to: "pages#about"
  get "contact", to: "pages#contact"

  resources :posts, only: [:show, :index] do
    collection do
      match 'search' => 'posts#search', via: [:get, :post], as: :search
    end
  end
  resources :categories
  resources :messages, only: :create
  resources :subscribers, only: [:create, :destroy]

  namespace :admin do
    get '/', to: 'dashboard#home'
    get 'site_posts', to: 'dashboard#site_posts'
    resources :posts do
      collection do
        match 'search' => 'posts#search', via: [:get, :post], as: :search
        get 'site_posts'
      end
      member do
        patch 'publish' => 'posts#update'
      end
    end
    resources :users
    resources :categories
    resources :images
    resources :messages, only: [:index, :show, :destroy]
    resources :subscribers, only: [:index, :show, :destroy]
    resources :stylesheets
    resources :themes, except: [:index]
    resources :menus
    resources :menu_items, only: [:create, :new, :show]
    get "contact", to: "pages#contact"
    post "create_image", to: "images#create"
    post "destroy_image", to: "images#destroy"
  end
end
