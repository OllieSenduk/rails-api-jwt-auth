source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'

gem 'jbuilder', '~> 2.5'
gem 'bcrypt'
gem 'rack-cors'
gem 'jwt'

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", "~> 3.8"
  gem "factory_bot_rails"
  gem "faker", git: "https://github.com/stympy/faker.git", branch: "master"
  gem 'pry'
end

group :test do 
  gem "shoulda-matchers"
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', '~> 0.70.0', require: false
  gem 'rubocop-rails'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]