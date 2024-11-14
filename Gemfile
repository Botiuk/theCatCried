# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.5'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '7.2.1.2'

# Support for additional languages
gem 'rails-i18n'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '6.4.3'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Kaminari - models can be paginated
gem 'kaminari'

# Generating data (faker)
gem 'faker'

# Authorization
gem 'devise'
gem 'devise-i18n'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.4'

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # RuboCop is a Ruby code style checking and code formatting tool.
  gem 'rubocop', '1.68.0', require: false
  # Automatic Rails code style checking tool.
  gem 'rubocop-rails', '2.27.0', require: false
  # A collection of RuboCop cops to check for performance optimizations in Ruby code.
  gem 'rubocop-performance', '1.22.1', require: false
end

group :production do
  # Use PostgreSQL as the database
  gem 'pg'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'webdrivers', '= 5.3.0'
end
