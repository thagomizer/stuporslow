require "test_helper"

class AthleteTest < ActiveSupport::TestCase
  def test_athlete
    a = Athlete.new(:first_name => "Fred", :last_name => "Rogers")
    assert a.save
  end
end
