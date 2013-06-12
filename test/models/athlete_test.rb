require "test_helper"

class AthleteTest < ActiveSupport::TestCase
  def test_athlete
    athlete = Athlete.new(:first_name => "Fred", :last_name => "Rogers")
    assert athlete.save
  end
end
