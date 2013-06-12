class Lift < ActiveRecord::Base
  belongs_to :exercise
  attr_accessible :exercise, :notes, :time, :weight

end
