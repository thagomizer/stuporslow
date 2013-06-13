class Lift < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :workout

  attr_accessible :exercise, :notes, :time, :weight, :workout

end
