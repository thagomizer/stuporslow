require "test_helper"

class WorkoutsControllerTest < ActionController::TestCase

  before do
    @workout = create_workout
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:workouts)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Workout.count', 1) do
      post :create, :workout => {"date(1i)"=>"2013", "date(2i)"=>"6", "date(3i)"=>"16", "notes"=>"Testing"}
    end

    assert_redirected_to workout_path(assigns(:workout))
  end

  def test_show
    get :show, id: @workout
    assert_response :success
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
