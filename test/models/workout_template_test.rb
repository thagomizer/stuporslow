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
  end
end
