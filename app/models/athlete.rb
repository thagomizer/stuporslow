class Athlete < ActiveRecord::Base
  has_many :workouts
  attr_accessible :first_name, :last_name
end
