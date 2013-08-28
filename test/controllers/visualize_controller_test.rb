require File.expand_path("../../test_helper", __FILE__)

class VisualizeControllerTest < ActionController::TestCase
  def setup
    fred = create_athlete
    sign_in fred
  end

  def test_get_graph
    get :graph
    assert_response :success
  end
end
