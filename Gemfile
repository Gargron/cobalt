source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Added at 2017-10-21 17:25:59 +0200 by eugr:
gem "shrine", "~> 2.8"

# Added at 2017-10-21 17:36:53 +0200 by eugr:
gem "sidekiq", "~> 5.0"

# Added at 2017-10-21 17:41:20 +0200 by eugr:
gem "streamio-ffmpeg", "~> 3.0"

# Added at 2017-10-21 17:50:34 +0200 by eugr:
gem "grape", "~> 1.0"

# Added at 2017-10-21 17:52:31 +0200 by eugr:
gem "hashie-forbidden_attributes", "~> 0.1.1"

# Added at 2017-10-21 18:03:47 +0200 by eugr:
gem "hamlit-rails", "~> 0.2.0"

# Added at 2017-10-21 20:57:07 +0200 by eugr:
gem "grape-active_model_serializers", "~> 1.5"

# Added at 2017-10-21 20:57:51 +0200 by eugr:
gem "active_model_serializers", "~> 0.10.6"

# Added at 2017-10-22 02:03:39 +0200 by eugr:
gem "mktorrent", "~> 1.7"

# Added at 2017-10-22 14:55:30 +0200 by eugr:
gem "pry-rails", "~> 0.3.6"

# Added at 2017-10-25 16:19:53 +0200 by eugr:
gem "fastimage", "~> 2.1"

# Added at 2017-10-25 16:20:03 +0200 by eugr:
gem "image_processing", "~> 0.4.5"

# Added at 2017-10-25 16:20:18 +0200 by eugr:
gem "mini_magick", "~> 4.8"
