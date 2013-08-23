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

  def test_exercises_for_athlete
    athlete = create_athlete
    exercises = []

    (1..10).each do |n|
      workout = Workout.new(:date => Time.now, :athlete => athlete)
      exercise = create_exercise("Exercise #{n}")
      exercises << exercise
      create_lift(workout, exercise)
      create_lift(workout, exercise)
      workout.save
    end

    found_exercises = Workout.exercises_for_athlete(athlete)

    exercises.each do |exercise|
      assert_include found_exercises, exercise
    end
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

  def test_all_workouts_with_exercise_for_athlete
    athlete   = create_athlete
    leg_press = create_exercise("Leg Press")
    pull_down = create_exercise("Pull Down")

    leg_press_workout = Workout.new(:date => Time.now, :athlete => athlete)
    create_lift(leg_press_workout, leg_press)
    leg_press_workout.save!

    pull_down_workout = Workout.new(:date => 2.days.ago, :athlete => athlete)
    create_lift(pull_down_workout, pull_down)
    pull_down_workout.save!

    found_workouts = Workout.all_workouts_with_exercise_for_athlete(pull_down, athlete)

    assert_equal 1, found_workouts.length
    assert_equal pull_down_workout, found_workouts[0]
  end
end
