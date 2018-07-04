Obtvse::Application.routes.draw do

  # Admin
  namespace :admin do
    resources :posts do
      resources :revisions, only: [:index, :show]
      resources :urls, only: :index
    end
  end

  # API
  namespace :api do
    post 'functions/markdown_preview' => 'functions#markdown_preview'
    post 'functions/slugify' => 'functions#slugify'
  end

  get '/posts.rss' => 'posts#index', as: 'rss'
  get '/p/:page'   => 'posts#index', as: 'page'
  get '/p/:page/posts.rss'   => 'posts#index', as: 'rss_page'

  resources :users
  resources :sessions
  resources :posts, path: '/', param: :slug, only: [:index, :show]

  root to: 'posts#index'

  # Sitemap
  get "sitemap/sitemap.xml" => "sitemap#index", as: "sitemap", defaults: { format: "xml" }
end
