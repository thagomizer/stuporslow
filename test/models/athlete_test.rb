require "test_helper"

class AthleteTest < ActiveSupport::TestCase
  def test_athlete
    athlete = Athlete.new(:first_name => "Fred",
                          :last_name  => "Rogers",
                          :email      => "fred@example.com",
                          :password   => "password")
    assert athlete.save
  end

  def test_lifts_for_exercise

    leg_ex = create_exercise("Leg Extension")
    lifts = []

    10.times do |x|
      workout = create_workout(x.weeks.ago)
      lifts << create_lift(workout, leg_ex)
    end

    athlete = lifts.first.workout.athlete

    assert_equal lifts, athlete.lifts_for_exercise(leg_ex)
  end
end
