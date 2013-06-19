require "test_helper"

class GoalsControllerTest < ActionController::TestCase

  before do
    sign_in_fred
    @goal = create_goal
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:goals)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Goal.count') do
      post :create, goal: {  }
    end

    assert_redirected_to goal_path(assigns(:goal))
  end

  def test_show
    get :show, id: @goal
    assert_response :success
  end

  def test_edit
    get :edit, id: @goal
    assert_response :success
  end

  def test_update
    put :update, id: @goal, goal: {  }
    assert_redirected_to goal_path(assigns(:goal))
  end

  def test_destroy
    assert_difference('Goal.count', -1) do
      delete :destroy, id: @goal
    end

    assert_redirected_to goals_path
  end
end
