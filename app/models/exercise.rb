class Exercise < ActiveRecord::Base
  has_many :lifts
  has_many :goals

  attr_accessible :name
end
