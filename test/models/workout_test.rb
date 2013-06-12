require "test_helper"

class WorkoutTest < ActiveSupport::TestCase
  def test_creation
    athlete = Athlete.create!(:first_name => "Fred", :last_name => "Rogers")

    workout = Workout.new( :notes   => "Test Notes",
                           :date    => Time.now,
                           :athlete => athlete)
    assert workout.save
    assert_equal athlete, workout.athlete
  end
end
