require "test_helper"

class VisualizeControllerTest < ActionController::TestCase
  def test_get_graph
    get :graph
    assert_response :success
  end
end
