source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3"
gem "dotenv-rails"

# Foreman
gem "foreman"

# Friendly ID
gem 'friendly_id', '~> 5.4.0'

# For js
gem 'jquery-rails'

# For Json serialization
gem 'active_model_serializers'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use sidekiq for background async tasks
gem "sidekiq", "~> 6.5"

# sidekiq uses sinatra for web interface
gem "sinatra"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Admin Panel
gem 'devise'
gem 'activeadmin'

# Unzip
gem 'rubyzip'

# Parsing PDFs
gem 'pdf-reader'
gem 'file_validators'

#policy management
# gem 'pundit'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# for Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'byebug'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'sqlite3'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'cucumber-rails-training-wheels'
  gem 'flores'
  gem 'simplecov'
  # database_cleaner is not required, but highly recommended
  # gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'google-cloud-storage'
  gem 'appengine'
end


