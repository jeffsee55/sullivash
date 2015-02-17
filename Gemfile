source "https://rubygems.org"

ruby "2.1.5"

gem "dotenv-rails"
gem "airbrake"
gem "bourbon", "~> 3.2.1"
gem "coffee-rails"
gem "delayed_job_active_record"
gem "email_validator"
gem "flutie"
gem "high_voltage"
gem "i18n-tasks"
gem "jquery-rails"
gem "neat", "~> 1.5.1"
gem "newrelic_rpm"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "rack-timeout"
gem "rails", "4.1.8"
gem "recipient_interceptor"
gem "sass-rails", "~> 4.0.3"
gem "simple_form"
gem "title"
gem "uglifier"
gem "unicorn"
gem 'haml', '~> 4.0.6'
gem 'haml-rails', '~> 0.6.0'
gem "wysiwyg-rails"
gem "mandrill-api", require: "mandrill"
gem "instagram"
gem "font-awesome-rails"
gem "nokogiri"
gem "mini_magick"
gem 'aws-sdk', '< 2'
gem "refile", require: ["refile/rails", "refile/image_processing"]
gem 'kaminari'
gem 'ransack', '~> 1.6.3'
gem 'impressionist'
gem 'clearance', '~> 1.8.0'
gem 'truncate_html', '~> 0.9.3'
gem 'whenever', '~> 0.9.4'
gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rbenv', github: "capistrano/rbenv"
gem 'friendly_id', '~> 5.1.0'

gem "bundler-audit"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem "guard"
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'quiet_assets'
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.0.0"
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
end
