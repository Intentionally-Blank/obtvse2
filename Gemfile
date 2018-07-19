source "https://rubygems.org"
ruby "2.5.0"

gem "dotenv-rails", groups: [:development, :test]

gem "rails", github: "rails/rails", branch: "5-2-stable"
gem "activerecord-session_store"
gem "pg"
gem "puma"

# Auth
gem "jwt"

# Frontend Utilities
gem "webpacker"

# Markdown/String Utilities
gem "coderay"
gem "diffy"
gem "kramdown", require: false
gem "stringex", github: "rsl/stringex"

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "minitest-rails"
  gem "pry"
  gem "pry-doc"
  gem "rails-controller-testing"
  gem "rubocop-rails_config"
  gem "simplecov", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
