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

  def create_workout(date = Time.now, notes = "")
    Workout.create!(:date => date, :notes => notes)
  end

  def create_exercise
    Exercise.find_or_create_by_name(:name => "Compound Row")
  end

  def create_goal(exercise = nil, athlete = nil, time = 90)
    exercise ||= create_exercise
    athlete  ||= create_athlete
    Goal.create!(:exercise => exercise, :athlete => athlete, :time => time)
  end

  def create_lift(workout = nil, exercise = nil)
    workout  ||= create_workout
    exercise ||= create_exercise
    Lift.create!(:workout => workout, :exercise => exercise)
  end
end
