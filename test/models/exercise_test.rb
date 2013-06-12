require "test_helper"

class ExerciseTest < ActiveSupport::TestCase
  def test_exercise_creation
    e = Exercise.new(:name => "Compound Row")
    assert e.save
  end
end
