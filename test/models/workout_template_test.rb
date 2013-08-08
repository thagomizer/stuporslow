require "test_helper"

class WorkoutTemplateTest < ActiveSupport::TestCase
  def test_create_workout_template
    athlete = create_athlete

    template = WorkoutTemplate.new(:name    => "My workout template",
                                   :athlete => athlete)

    exercise1 = Exercise.create!(:name => "Exercise1")
    exercise2 = Exercise.create!(:name => "Exercise2")

    goal1 = Goal.create(:exercise => exercise1, :time => 30)
    goal2 = Goal.create(:exercise => exercise2, :time => 60)

    template.goals = [goal1, goal2]

    assert template.save

    template.reload

    assert_equal athlete, template.athlete
    assert_equal 2, template.goals.count

    assert_equal goal1, template.goals[0]
    assert_equal goal2, template.goals[1]
  end

  def test_do_not_save_goals_with_no_time
    template = WorkoutTemplate.new(:name => "Testing")
    template.goals << Goal.new(:exercise => Exercise.first)
    template.goals << Goal.new(:exercise => Exercise.first,
                               :time => 120)

    assert template.save

    assert_equal 1, template.goals.length
  end

end
