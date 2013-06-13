class Athlete < ActiveRecord::Base
  has_many :workouts
  has_many :goals

  attr_accessible :first_name, :last_name
end
