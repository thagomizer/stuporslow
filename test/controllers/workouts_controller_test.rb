require File.expand_path("../../test_helper", __FILE__)

class WorkoutsControllerTest < ActionController::TestCase

  def setup
    @fred     = create_athlete
    @exercise = create_exercise
    @workout  = create_workout
    @workout_template = create_workout_template
    create_lift(@workout)

    sign_in @fred
  end

  # index
  def test_index
    get :index
    assert_response :success
    refute_nil assigns(:workouts)

    assert_select 'tr', 2
    assert_select 'td', :html => "#{@workout.date.strftime('%b %-d %Y')}"
    assert_select 'td', :html => "#{@workout.notes}"

    assert_match "New Workout From Test Workout Template", response.body
    assert_match "New Workout Template", response.body
  end

  # show
  def test_show
    get :show, id: @workout
    assert_response :success

    lift = @workout.lifts.first

    assert_select 'tr', @workout.lifts.count + 1
    assert_select 'td.lift-exercise-name', :text => lift.exercise.name
    assert_select 'td.lift-weight', :text => lift.weight
    assert_select 'td.lift-time', :text => lift.time
    assert_select 'td.lift-notes', :text => lift.notes
  end

  # new
  def test_new
    get :new
    assert_response :success

    workout = assigns(:workout)
    refute_nil workout
    assert_equal 6, workout.lifts.length

    t = Time.now

    assert_select "#workout_date_1i", :value => t.year
    assert_select "#workout_date_2i", :value => t.day
    assert_select "#workout_date_3i", :value => t.month

    assert_select 'div.lift-row', 6

    6.times do |x|
      assert_select "#workout_lifts_attributes_#{x}_exercise_id"
      assert_select "#workout_lifts_attributes_#{x}_weight"
      assert_select "#workout_lifts_attributes_#{x}_time"
      assert_select "#workout_lifts_attributes_#{x}_notes"
    end
  end

  def test_new_from_template
    get :new, :template_id => @workout_template.id
    assert_response :success

    workout = assigns(:workout)
    refute_nil workout

    assert_equal @workout_template.goals.length, workout.lifts.length
  end

  # edit TODO
  def test_edit
    get :edit, id: @workout
    assert_response :success
  end

  # create
  def test_create
    assert_difference('Workout.count', 1) do
      post :create, :workout => {"date(1i)"         => "2013",
                                 "date(2i)"         => "6",
                                 "date(3i)"         => "16",
                                 "notes"            => "Testing",
                                 "lifts_attributes" => {"0" =>
                                   {"exercise_id" => @exercise.id,
                                    "weight"      => 150,
                                    "time"        => 100,
                                    "notes"       => "My notes"}}}
    end

    assert_redirected_to workout_path(assigns(:workout))

    new_workout = Workout.last

    assert_equal @fred, new_workout.athlete
  end

  # update
  def test_update
    put :update, id: @workout, workout: {  }
    assert_redirected_to workout_path(assigns(:workout))
  end

  # destroy
  def test_destroy
    assert_difference('Workout.count', -1) do
      delete :destroy, id: @workout
    end

    assert_redirected_to workouts_path
  end
end
