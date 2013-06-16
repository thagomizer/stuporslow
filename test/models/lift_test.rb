require "test_helper"

class LiftTest < ActiveSupport::TestCase
  def test_creation
    exercise = Exercise.find_or_create_by_name(:name => "Exercise1")

    athlete = create_athlete

    workout = Workout.create!(:date => Time.now,
                              :notes => "",
                              :athlete => athlete)

    lift = Lift.new(:exercise => exercise,
                    :weight   => 200,
                    :time     => 96,
                    :workout  => workout,
                    :notes    => "Test lift")

    assert lift.save
    assert_equal exercise, lift.exercise
    assert_equal workout, lift.workout
  end
end
