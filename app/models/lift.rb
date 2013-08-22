class Lift < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :workout

  attr_accessible :exercise, :exercise_id, :notes, :time, :weight, :workout
end
