require "test_helper"

class ExerciseTest < ActiveSupport::TestCase
  def test_exercise_creation
    exercise = Exercise.new(:name => "Compound Row")
    assert exercise.save
  end
end
