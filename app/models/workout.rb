class Workout < ActiveRecord::Base
  belongs_to :athlete
  attr_accessible :athlete, :date, :notes
end
