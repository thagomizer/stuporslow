class Workout < ActiveRecord::Base
  belongs_to :athlete
  has_many :lifts

  attr_accessible :athlete, :date, :notes
end
