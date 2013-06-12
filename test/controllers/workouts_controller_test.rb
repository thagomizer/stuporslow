require "test_helper"

class WorkoutsControllerTest < ActionController::TestCase

  before do
    @workout = workouts(:one)
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
    assert_difference('Workout.count') do
      post :create, workout: {  }
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
