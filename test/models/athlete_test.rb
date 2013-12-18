require "test_helper"

class AthleteTest < ActiveSupport::TestCase
  def test_athlete
    athlete = Athlete.new(:first_name => "Fred",
                          :last_name  => "Rogers",
                          :email      => "fred@example.com",
                          :password   => "password")
    assert athlete.save
    athlete.reload

    assert_equal "Fred", athlete.first_name
    assert_equal "Rogers", athlete.last_name
    assert_equal "fred@example.com", athlete.email
    assert_equal "password", athlete.password

    assert_equal [], athlete.workouts
    assert_equal [], athlete.workout_templates
  end

  def test_athletes_have_workouts
    athlete = create_athlete
    athlete.workouts << Workout.new
    athlete.workouts << Workout.new

    assert_equal 2, athlete.workouts.count
  end

  def test_athletes_have_workout_templates
    athlete = create_athlete
    athlete.workout_templates << WorkoutTemplate.new
    athlete.workout_templates << WorkoutTemplate.new

    assert_equal 2, athlete.workout_templates.count
  end

  def test_lifts_for_exercise
    leg_ex = create_exercise("Leg Extension")
    lifts = []

    10.times do |x|
      workout = create_workout(x.weeks.ago)
      lifts << create_lift(workout, leg_ex)
    end

    athlete = lifts.first.workout.athlete

    assert_equal lifts, athlete.lifts_for_exercise(leg_ex)
  end
end
