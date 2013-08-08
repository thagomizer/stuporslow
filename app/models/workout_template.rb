class WorkoutTemplate < ActiveRecord::Base
  belongs_to :athlete
  has_many :goals
  before_save :remove_empty_goals

  attr_accessible :name, :athlete, :goals_attributes

  accepts_nested_attributes_for :goals

  def remove_empty_goals
    self.goals.delete_if { |goal| goal.time.nil? }
  end
end
