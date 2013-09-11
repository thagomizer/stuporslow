require "test_helper"

class SmokeTest < ActionDispatch::IntegrationTest
  def setup
    @athlete = create_athlete
  end

  def test_login
    get '/sign_in'
    assert_response :success

    post_via_redirect '/sign_in', "athlete" => {"email" => @athlete.email,
      "password" => "password",
      "remember_me" => "0"}
    assert_response :success
    assert_equal '/', path

    get '/visualize/graph'
    assert_response :success
    assert assigns(:exercise_data)
  end
end
