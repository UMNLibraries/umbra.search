source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# Had to downgrade therubyracer due to segfaults outlined here: https://github.com/metaskills/less-rails/issues/95
gem 'therubyracer', '~> 0.11.4'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'blacklight'
gem 'rails_autolink'
gem 'haml'
gem 'aws-sdk', '< 2'
gem 'sidekiq'

group :test, :development do
  # Debug seems to have trouble w/ Ruby 2.x, byebug is a replacment
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'coderay', '~> 1.0.5'
  # Quite logs down by removing asset requests
  gem 'quiet_assets'
  gem 'fontello_rails_converter'
  gem 'capistrano', '~> 3.2.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rvm'
  gem 'rspec-rails', '>3.0'
  gem 'capybara'
end