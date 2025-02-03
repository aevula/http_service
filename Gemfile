# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :development, :test do
  gem 'byebug'
  gem 'rake', require: false
  gem 'rspec', require: false
end

group :development, :lint do
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'factory_bot', require: false
  gem 'faker', require: false
  gem 'rspec_junit_formatter', require: false
  gem 'simplecov', require: false
  gem 'simplecov-cobertura', require: false
end
