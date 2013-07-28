require "test_helper"

class GoalTest < ActiveSupport::TestCase
  def test_goal_creation
    exercise = Exercise.create!(:name => "Compound Row")
    template = WorkoutTemplate.create!(:name => "Template")

    goal = Goal.new(:exercise         => exercise,
                    :time             => 60,
                    :workout_template => template)

    assert goal.save
    assert_equal exercise, goal.exercise
  end
end
