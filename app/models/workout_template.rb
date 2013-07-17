class WorkoutTemplate < ActiveRecord::Base
  attr_accessible :athlete_id, :name, :athlete, :goals
  has_one :athlete
  has_many :goals
end
