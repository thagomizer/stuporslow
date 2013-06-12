require "test_helper"

class LiftTest < ActiveSupport::TestCase
  def test_creation
    exercise = Exercise.find_or_create_by_name(:name => "Exercise1")
    lift = Lift.new(:exercise => exercise,
                    :weight => 200,
                    :time => 96,
                    :notes => "Test lift")
    assert lift.save
    assert_equal exercise, lift.exercise
  end
end
