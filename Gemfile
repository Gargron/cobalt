source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = '#{repo_name}/#{repo_name}' unless repo_name.include?('/')
  'https://github.com/#{repo_name}.git'
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'bootsnap'

group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails', '~> 3.7'
end

gem 'shrine', '~> 2.8'
gem 'sidekiq', '~> 5.0'
gem 'streamio-ffmpeg', '~> 3.0'
gem 'grape', '~> 1.0'
gem 'hashie-forbidden_attributes', '~> 0.1.1'
gem 'hamlit-rails', '~> 0.2.0'
gem 'grape-active_model_serializers', '~> 1.5'
gem 'active_model_serializers', '~> 0.10.6'
gem 'bencode'
gem 'pry-rails', '~> 0.3.6'
gem 'fastimage', '~> 2.1'
gem 'image_processing', '~> 0.4.5'
gem 'mini_magick', '~> 4.8'
gem 'addressable', '~> 2.5'
gem 'fast_blank', '~> 1.0'
gem 'http', '~> 2.2'
gem 'oj', '~> 3.0'
gem 'rdf-normalize', '~> 0.3.1'
gem 'hiredis', '~> 0.6'
gem 'redis', '~> 4.0', require: ['redis', 'redis/connection/hiredis']
