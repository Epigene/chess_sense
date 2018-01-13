source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'rails', '~> 5.2.0.beta2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.11'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :production do
  gem 'newrelic_rpm', '~> 4.2.0.334'
end

group :development do
  gem 'better_errors', '~> 2.1.1' # nodrošina detalizētākus error paziņojumus
  gem 'listen', '>= 3.0.5', '< 3.2', require: false # yuck
  gem 'spring', '~> 2.0.2', require: false
  gem 'annotate', '~> 2.7.2', require: false
end

group :development, :test do
  gem 'dotenv-rails', '~> 2.2.1' # .env file support
  gem 'pry-rails', '~> 0.3.6'
  gem 'awesome_print', '~> 1.8.0'
end

group :test do
  gem 'simplecov', '~> 0.14.1'
  gem 'rspec-rails', '~> 3.7.0', require: false
  gem 'spring-commands-rspec', '~> 1.0.4', require: false # Spring for rspec ^
  gem 'rails-controller-testing', '~> 1.0.2'
  gem 'factory_bot', '~> 4.8.2', require: false
  gem 'timecop', '~> 0.8.1', require: false
  gem 'database_cleaner', '~> 1.6.1', require: false
end
