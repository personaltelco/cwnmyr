source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.3'
gem 'rails'

gem 'foreman'
gem 'pg'
gem 'puma', '~> 3.0'

gem 'administrate'
gem 'bootstrap-sass'
gem 'bourbon'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'dotenv-rails'
gem 'haml-rails'
gem 'high_voltage'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'omniauth'
gem 'pundit'
gem 'redcarpet'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'

gem 'geocoder'
gem 'gmaps4rails'
gem 'netaddr', require: 'cidr'
gem 'rgl', require: 'rgl/adjacency'
gem 'rmagick'
gem 'underscore-rails'

group :development do
  gem 'better_errors'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-foreman',
      github: 'koenpunt/capistrano-foreman', branch: 'systemd'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'haml_lint', require: false
  gem 'html2haml'
  gem 'listen', '~> 3.0.5'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'poltergeist'
  gem 'shoulda-matchers',
      github: 'thoughtbot/shoulda-matchers', branch: 'rails-5'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
end
