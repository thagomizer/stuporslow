class Workout < ActiveRecord::Base
  belongs_to :athlete
  has_many :lifts

  attr_accessible :athlete, :date, :notes, :lifts_attributes

  accepts_nested_attributes_for :lifts
end
