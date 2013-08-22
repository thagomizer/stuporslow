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

  def test_new_from_template
    workout_template = create_workout_template

    workout = Workout.new_from_template(workout_template)
    assert_equal 1, workout.lifts.length

    goal = workout_template.goals.first
    lift = workout.lifts.first

    assert_equal goal.exercise, lift.exercise
    assert_equal goal.time, lift.time
  end

  def test_default_workout
    workout = Workout.default_workout

    assert_equal 6, workout.lifts.length
  end

  def test_do_not_save_lifts_with_no_weight
    workout = Workout.new(:date => Time.now)
    workout.lifts << Lift.new(:exercise => Exercise.first,
                              :weight => 300,
                              :time => 120)
    workout.lifts << Lift.new(:exercise => Exercise.first)

    assert workout.save

    assert_equal 1, workout.lifts.length
  end

  def test_exercise_names_for_athlete
    athlete = create_athlete

    workout = Workout.new(:date => Time.now, :athlete => athlete)
    workout.lifts << create_lift
    workout.lifts << create_lift

    assert_equal(workout.lifts.map { |l| l.exercise.name }.flatten.uniq,
                 Workout.exercise_names_for_athlete(workout.athlete))
  end

  def test_dates_for_athlete
    athlete = create_athlete

    workout = Workout.new(:date => Time.now, :athlete => athlete)

    Workout.dates_for_athlete(athlete).each do |date|
      assert_in_delta Time.now, date
    end
  end

  def test_last_n_for_athlete
    athlete = create_athlete("LastN", "Test")

    created_workouts = []
    2.times do
      workout = Workout.new(:date => Time.now, :athlete => athlete)
      workout.lifts << create_lift
      workout.save
      created_workouts << workout
    end

    found_workouts = Workout.last_n_for_athlete(1, athlete)

    assert_equal 1, found_workouts.length
    assert_equal created_workouts.last, found_workouts.first
  end
end
