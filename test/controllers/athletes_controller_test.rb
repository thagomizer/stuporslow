require "test_helper"

class AthletesControllerTest < ActionController::TestCase
  before do
    @athlete = create_athlete
    sign_in @athlete
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:athletes)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Athlete.count', 1) do
      post :create, :athlete => { :first_name => "Mike",
                                  :last_name  => "Smith",
                                  :email      => "mike@example.com",
                                  :password   => "password"}
    end

    assert_redirected_to athlete_path(assigns(:athlete))
  end

  def test_show
    get :show, id: @athlete
    assert_response :success
  end

  def test_edit
    get :edit, id: @athlete
    assert_response :success
  end

  def test_update
    put :update, id: @athlete, athlete: {  }
    assert_redirected_to athlete_path(assigns(:athlete))
  end

  def test_destroy
    assert_difference('Athlete.count', -1) do
      delete :destroy, id: @athlete
    end

    assert_redirected_to athletes_path
  end
end
