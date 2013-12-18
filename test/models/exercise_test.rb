require "test_helper"

class ExerciseTest < ActiveSupport::TestCase
  def test_exercise_creation
    exercise = Exercise.new(:name => "Compound Row")
    assert exercise.save
    exercise.reload

    assert_equal "Compound Row", exercise.name
  end
end
