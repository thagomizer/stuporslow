class Exercise < ActiveRecord::Base
  has_many :lifts
  attr_accessible :name
end
