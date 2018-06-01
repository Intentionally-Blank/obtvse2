Obtvse::Application.routes.draw do

  # Admin
  namespace :admin do
    resources :posts
  end

  get '/posts(.:format)' => 'posts#index'
  get '/posts.rss' => 'posts#index', as: 'rss'

  resources :users
  resources :sessions
  resources :posts, path: '/', param: :slug

  get '/:slug' => 'posts#show', as: 'post_slug'

  root to: 'posts#index'

  # Sitemap
  get "sitemap/sitemap.xml" => "sitemap#index", as: "sitemap", defaults: { format: "xml" }
end
