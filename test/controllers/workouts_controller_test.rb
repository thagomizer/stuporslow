require "test_helper"

class WorkoutsControllerTest < ActionController::TestCase

  before do
    sign_in_fred
    @workout = create_workout
    create_lift(@workout)
  end

  # index
  def test_index
    get :index
    assert_response :success
    refute_nil assigns(:workouts)

    assert_select 'tr', 2
    assert_select 'td', :html => "#{@workout.date.strftime('%b %-d %Y')}"
    assert_select 'td', :html => "#{@workout.notes}"
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

    0.upto(5) do |x|
      assert_select "#workout_lifts_attributes_#{x}_exercise_id"
      assert_select "#workout_lifts_attributes_#{x}_weight"
      assert_select "#workout_lifts_attributes_#{x}_time"
      assert_select "#workout_lifts_attributes_#{x}_notes"
    end
  end

  # create
  def test_create
    assert_difference('Workout.count', 1) do
      post :create, :workout => {"date(1i)"=>"2013", "date(2i)"=>"6", "date(3i)"=>"16", "notes"=>"Testing"}
    end

    assert_redirected_to workout_path(assigns(:workout))

    new_workout = Workout.last

    assert_equal @fred.email, new_workout.athlete.email
  end

  def test_edit
    get :edit, id: @workout
    assert_response :success
  end

  def test_update
    put :update, id: @workout, workout: {  }
    assert_redirected_to workout_path(assigns(:workout))
  end

  def test_destroy
    assert_difference('Workout.count', -1) do
      delete :destroy, id: @workout
    end

    assert_redirected_to workouts_path
  end
end
