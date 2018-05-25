source "https://rubygems.org"
ruby "2.5.0"

gem "rails", "5.2.0"
gem "activerecord-session_store"
gem "pg"
gem "puma"

# Auth
gem "jwt"

# Frontend Utilities
gem "webpacker"

# Markdown
gem "coderay"
gem "kramdown", require: false

# Pagination
gem "kaminari"

# Date/URL Utilities
gem "chronic"
gem "stringex", github: "rsl/stringex"

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "minitest-rails"
  gem "pry"
  gem "pry-doc"
  gem "rails-controller-testing"
  gem "rubocop-rails"
  gem "simplecov", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :assets do
  gem "coffee-rails"
  gem "sass-rails"
  gem "uglifier"
end
