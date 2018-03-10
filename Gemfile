source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'rails', '~> 5.2.0.rc1'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg', '~> 0.21' # 1.0.0 not supported by AR yet
gem 'puma', '~> 3.11'

gem 'slim-rails', '~> 3.1.3'
gem 'simple_form', '~> 3.5.1'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'

gem 'egd',
  #'>= 1.0.1',
  path: "local/egd"
gem 'jsonb_accessor', '~> 1.0.0'
gem 'retryable', '~> 3.0.0'

group :production do
  gem 'newrelic_rpm', '~> 4.2.0.334'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2', require: false # yuck
  gem 'spring', '~> 2.0.2', require: false
  gem 'annotate', '~> 2.7.2'#, require: false
end

group :development, :test do
  gem 'better_errors', '~> 2.1.1' # nodrošina detalizētākus error paziņojumus
  gem 'rspec-rails', '~> 3.7.0'
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'spring-commands-rspec', '~> 1.0.4', require: false # Spring for rspec ^
  gem 'dotenv-rails', '~> 2.2.1' # .env file support
  gem 'pry-rails', '~> 0.3.6'
  gem 'awesome_print', '~> 1.8.0'
end

group :test do
  gem 'coveralls', '~> 0.8.21'
  gem 'simplecov', '~> 0.14.1'
  gem 'rails-controller-testing', '~> 1.0.2'
  gem 'timecop', '~> 0.8.1', require: false
  gem 'database_cleaner', '~> 1.6.1', require: false
end
