Obtvse::Application.routes.draw do

  # Admin
  namespace :admin do
    resources :posts do
      resources :revisions, only: [:index, :show]
      resources :urls, only: :index
    end
  end

  get '/posts.rss' => 'posts#index', as: 'rss'

  resources :users
  resources :sessions
  resources :posts, path: '/', param: :slug, only: [:index, :show]

  root to: 'posts#index'

  # Sitemap
  get "sitemap/sitemap.xml" => "sitemap#index", as: "sitemap", defaults: { format: "xml" }
end
