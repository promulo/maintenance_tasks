# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "capybara"
gem "mocha"
gem "pg"
gem "pry-byebug"
gem "puma"
if defined?(@rails_gem_requirement) && @rails_gem_requirement
  # causes Dependabot to ignore the next line and update the next gem "rails"
  rails = "rails"
  gem rails, @rails_gem_requirement
else
  gem "rails"
end
gem "rubocop"
gem "rubocop-shopify", "2.3.0"
gem "selenium-webdriver"
gem "sorbet", group: :development
gem "sorbet-runtime"
gem "sqlite3"
gem "webdrivers", require: false
gem "yard"
