source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'jquery-rails'
gem 'sass-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'coffee-script-source', '1.5.0' # stupid hack because 1.6.3 does not show
																	  # line numbers in error messages
gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'
gem 'uglifier', '>= 1.3.0'
gem 'newrelic_rpm'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'figaro'
gem 'devise'
gem 'will_paginate'
gem 'ancestry'
gem 'thumbs_up'
gem 'acts_as_follower'
gem 'draper', '~> 1.3'

group :development do
	gem 'sqlite3'
	gem 'mailcatcher'
end

group :development, :test do
	gem 'rspec-rails'
	gem 'factory_girl_rails'
	gem 'terminal-notifier-guard'
	gem 'launchy'
	gem 'betterlorem'
end

group :test do
	gem 'capybara'
	gem 'database_cleaner', '>= 1.2.0'
	gem 'spork-rails', github: 'sporkrb/spork-rails'
	gem 'guard-rspec'
	gem 'guard-spork'
	gem 'rb-fsevent'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
	gem 'pg'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
