class WorkoutTemplate < ActiveRecord::Base
  belongs_to :athlete
  has_many :goals

  attr_accessible :name, :athlete, :goals_attributes

  accepts_nested_attributes_for :goals
end
