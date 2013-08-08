require "test_helper"

class WorkoutTemplatesControllerTest < ActionController::TestCase

  def setup
    @athlete = create_athlete
    @workout_template = WorkoutTemplate.create!(:name    => "My Template",
                                                :athlete => @athlete)

    Goal.create!( :workout_template => @workout_template,
                  :exercise         => create_exercise,
                  :time             => 90)

    sign_in @athlete
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:workout_templates)
  end

  def test_new
    get :new
    assert_response :success

    template = assigns(:workout_template)
    refute_nil template
    assert_equal 6, template.goals.length

    assert_select "#workout_template_name"

    0.upto(5).each do |x|
      assert_select "#workout_template_goals_attributes_#{x}_exercise_id"
      assert_select "#workout_template_goals_attributes_#{x}_time"
    end
  end

  def test_create
    assert_difference('WorkoutTemplate.count') do
      assert_difference('Goal.count', 2) do
        post :create,  "workout_template" => {
          "name" => "Template Name",
          "goals_attributes" => {
            "0" => {
              "exercise_id" => Exercise.first.id.to_s,
              "time"        => "120"},
            "1" => {
              "exercise_id" => Exercise.last.id.to_s,
              "time"        => "90"}}}
      end
    end

    template = WorkoutTemplate.last

    assert_equal 2, template.goals.count
    assert_equal @athlete, template.athlete

    assert_redirected_to workout_template_path(assigns(:workout_template))
  end

  def test_create_no_time
    assert_difference('WorkoutTemplate.count') do
      assert_difference('Goal.count', 1) do
        post :create,  "workout_template" => {
          "name" => "Template Name",
          "goals_attributes" => {
            "0" => {
              "exercise_id" => Exercise.first.id.to_s,
              "time"        => "120"},
            "1" => {
              "exercise_id" => Exercise.last.id.to_s,
              "time"        => ""}}}
      end
    end

    assert_redirected_to workout_template_path(assigns(:workout_template))
  end

  def test_show
    get :show, id: @workout_template
    assert_response :success

    goal = @workout_template.goals.first

    assert_select 'tr', @workout_template.goals.count + 1
    assert_select 'td.goal-exercise-name', :text => goal.exercise.name
    assert_select 'td.goal-time', :text => goal.time
  end

  def test_edit
    get :edit, id: @workout_template
    assert_response :success

    assert_select '#workout_template_name', :value => @workout_template.name

    @workout_template.goals.each do |goal|
      assert_match /#{goal.exercise.name}/, response.body
      assert_match /#{goal.time}/, response.body
    end
  end

  def test_update
    put :update, id: @workout_template, "workout_template" => {
          "name" => "Template Name",
          "goals_attributes" => {
            "0" => {
              "exercise_id" => Exercise.first.id.to_s,
              "time"        => "120"},
            "1" => {
              "exercise_id" => Exercise.last.id.to_s,
              "time"        => "50"}}}

    assert_redirected_to workout_template_path(assigns(:workout_template))

    template = assigns(:workout_template)
  end

  def test_destroy
    assert_difference('WorkoutTemplate.count', -1) do
      delete :destroy, id: @workout_template
    end

    assert_redirected_to workout_templates_path
  end
end
