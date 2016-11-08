source 'https://rubygems.org'

gem 'rails', '5.0.0'

### for DB ###
gem 'foreigner'
gem 'composite_primary_keys'
# gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
### API ###
gem 'rabl'
gem 'versionist'
# gem 'rocket_pants', '~>1.13.1'

### Assets ###
gem 'turbolinks', '~>5.0.0'

gem 'jquery-rails', '~> 4.1.1'
gem 'jquery-ui-rails'
gem 'jquery-fileupload-rails'
gem 'coffee-rails', github: 'rails/coffee-rails', branch: 'master'
gem 'sass-rails', '~> 5.0.6'
gem 'haml', '~> 4.0.7'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'bootswatch-rails', '~> 3.3.5'
gem 'font-awesome-rails'
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'rest-client', '~>2.0.0'
gem 'async-rails'
gem 'responders'
gem 'ancestry'

# gem 'bootstrap-wysihtml5-rails', '~> 0.3.3.8'
gem 'bootstrap-wysihtml5-rails', github: 'nerian/bootstrap-wysihtml5-rails'
gem 'will_paginate-bootstrap', '~> 1.0.1'

#for authorization, authentification & roles for user
gem 'devise',           '~> 4.2.0',  '>=4.2.0'
gem 'devise_token_auth','~> 0.1.39', '>=0.1.39'
gem 'devise_invitable', '~> 1.7.0'

gem 'cancancan',        '~> 1.15', '>=1.15.0'

# gem 'omniauth'
# gem 'omniauth-facebook'


#-------- NEED TO USE THESE gems ------!!!-
#https://github.com/chaps-io/public_activity
# gem 'public_activity'
# gem 'web-console', '~> 3.0'
#--------------------------------------!!!-

group :development do
  gem 'puma', '~> 3.6.0' ### Server
  gem 'mysql2' ### DB
  ### For Deployment ###
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.1'
  gem 'capistrano-rbenv', github: 'capistrano/rbenv'
  ### For debuging ###
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'meta_request'
  gem 'better_errors', '~> 2.1.0'
  gem 'binding_of_caller'
  gem 'rubocop', require: false
  gem 'awesome_print'
  gem 'brakeman', require: false
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5.1'
  gem 'factory_girl', '~>4.7.0'
  gem 'simplecov', require: false
  gem 'byebug'
end

group :production do
  gem 'pg' ### DB
end