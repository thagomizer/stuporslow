require "test_helper"

class WorkoutTemplatesControllerTest < ActionController::TestCase

  def setup
    athlete = create_athlete
    @workout_template = WorkoutTemplate.create!(:name    => "My Template",
                                                :athlete => athlete)

    Goal.create!(:workout_template => @workout_template,
                 :exercise         => create_exercise,
                 :time             => 90)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:workout_templates)
  end

  def test_new
    get :new

    template = assigns(:workout_template)
    refute_nil template
    assert_equal 1, template.goals.count

    assert_select "#workout_template_name"

    # Should not have field for athlete
    # Should have table of up to

    assert_response :success
  end

  # def test_create
  #   assert_difference('WorkoutTemplate.count') do
  #     post :create, workout_template: {  }
  #   end

  #   assert_redirected_to workout_template_path(assigns(:workout_template))
  # end

  # def test_show
  #   get :show, id: @workout_template
  #   assert_response :success
  # end

  # def test_edit
  #   get :edit, id: @workout_template
  #   assert_response :success
  # end

  # def test_update
  #   put :update, id: @workout_template, workout_template: {  }
  #   assert_redirected_to workout_template_path(assigns(:workout_template))
  # end

  # def test_destroy
  #   assert_difference('WorkoutTemplate.count', -1) do
  #     delete :destroy, id: @workout_template
  #   end

  #   assert_redirected_to workout_templates_path
  # end
end
