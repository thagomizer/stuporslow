class Goal < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :exercise

  attr_accessible :athlete, :exercise, :time
end
