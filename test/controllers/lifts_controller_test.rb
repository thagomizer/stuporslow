require "test_helper"

class LiftsControllerTest < ActionController::TestCase

  before do
    @lift = create_lift
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:lifts)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Lift.count') do
      post :create, lift: {  }
    end

    assert_redirected_to lift_path(assigns(:lift))
  end

  def test_show
    get :show, id: @lift
    assert_response :success
  end

  def test_edit
    get :edit, id: @lift
    assert_response :success
  end

  def test_update
    put :update, id: @lift, lift: {  }
    assert_redirected_to lift_path(assigns(:lift))
  end

  def test_destroy
    assert_difference('Lift.count', -1) do
      delete :destroy, id: @lift
    end

    assert_redirected_to lifts_path
  end
end
