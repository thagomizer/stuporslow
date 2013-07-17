require "test_helper"

class GoalTest < ActiveSupport::TestCase
  def test_goal_creation
    exercise = Exercise.create!(:name => "Compound Row")

    goal = Goal.new(:exercise => exercise, :time => 60)
    assert goal.save
    assert_equal exercise, goal.exercise
  end
end
