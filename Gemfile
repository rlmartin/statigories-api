require 'rbconfig'
HOST_OS = Config::CONFIG['host_os']
source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem "andand"
gem "devise", ">= 1.4.5"
gem "haml", ">= 3.1.2"
gem "haml-rails", ">= 0.3.4", :group => :development
gem 'jquery-rails'
gem 'mysql'
gem "rspec-rails", ">= 2.6.1", :group => [:development, :test]

group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :test do
  gem "cucumber-rails", ">= 1.0.2", :group => :test
  gem "capybara", ">= 1.1.1", :group => :test
  gem "database_cleaner", ">= 0.6.7", :group => :test
  gem "factory_girl_rails", ">= 1.2.0", :group => :test
  gem "launchy", ">= 2.0.5", :group => :test
  gem 'turn', :require => false
end
if HOST_OS =~ /linux/i
  gem 'therubyracer', '>= 0.8.2'
end
