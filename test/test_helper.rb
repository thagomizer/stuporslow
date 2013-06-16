ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
require "minitest/pride"

class ActiveSupport::TestCase
  def create_athlete(first_name = "Fred", last_name = "Rogers")
    Athlete.find_or_create_by_email(:first_name => first_name,
                                    :last_name  => last_name,
                                    :email      => "#{first_name}@example.com",
                                    :password   => "password")
  end

#  fixtures :all

  # Add more helper methods to be used by all tests here...
end
