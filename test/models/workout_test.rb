require "test_helper"

class WorkoutTest < ActiveSupport::TestCase
  def test_creation
    athlete = create_athlete

    workout = Workout.new( :notes   => "Test Notes",
                           :date    => Time.now,
                           :athlete => athlete)
    assert workout.save
    assert_equal athlete, workout.athlete
  end

  def test_creation_with_nested_attributes
    athlete = create_athlete

    workout = Workout.new( :notes   => "Test Notes",
                           :date    => Time.now,
                           :athlete => athlete)

    exercise = create_exercise
    lift1 = Lift.new(:exercise => exercise, :time => 100, :weight => 50)

    workout.lifts << lift1


    assert_difference 'Lift.count' do
      assert_difference 'Workout.count' do
        workout.save!
      end
    end

    l = Lift.last
    assert_equal workout, l.workout
    assert_equal exercise.id, l.exercise_id
    assert_equal 100, l.time
    assert_equal 50, l.weight
  end
end
