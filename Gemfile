source 'http://rubygems.org'

gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem "cancan"
gem 'devise', '1.2.1'
gem 'devise_invitable', '0.4.rc5'
gem 'haml'
gem "hpricot"
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem "rbrainz"
gem "ruby_parser"
gem 'simple_form'  #remember to run: rails generate simple_form:install
gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'youtube_it'


group :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'mocha'
  gem 'shoulda'
  gem 'test-unit'
end

group :development do
  gem 'hirb'
  #GENERATORS
  #Rails 3 compatible generators for gems that don’t have them yet
  gem 'rails3-generators'

  #generator to produce haml templates instead of default erb for scaffolds etc
  #https://github.com/indirect/haml-rails
  gem "haml-rails"

  #deploy staging, production easily to heroku
  gem 'heroku_san'

  #jquery generator for rails : https://github.com/indirect/jquery-rails
  #Then, run bundle install. To invoke the generator, run:
  #rails generate jquery:install #--ui to enable jQuery UI --version to install specific version of JQuery (default is 1.4.2)
  #You're done! Don't forget to output csrf_meta_tag somewhere inside your <head> tag in your layout!
  gem "jquery-rails"
end




