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

  def test_all_with_athlete_exercise
    athlete = create_athlete
    abs     = create_exercise("abs")
    back    = create_exercise("back")

    abs_workout = Workout.new(:date => Time.now, :athlete => athlete)
    abs_lift    = create_lift(abs_workout, abs)
    abs_workout.save!

    back_workout = Workout.new(:date => Time.now, :athlete => athlete)
    back_lift    = create_lift(back_workout, back)
    back_workout.save!

    found_lifts = Lift.all_with_athlete_exercise(athlete, abs)

    assert_equal 1, found_lifts.length
    assert_equal abs_lift, found_lifts[0]
  end

  def test_date
    workout = create_workout

    assert_equal workout.date, workout.lifts[0].date
  end
end
