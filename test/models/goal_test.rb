require "test_helper"

class GoalTest < ActiveSupport::TestCase
  def test_goal_creation
    exercise = Exercise.create!(:name => "Compound Row")
    athlete = create_athlete

    goal = Goal.new(:exercise => exercise, :athlete => athlete, :time => 60)
    assert goal.save
    assert_equal exercise, goal.exercise
    assert_equal athlete, goal.athlete
  end
end
