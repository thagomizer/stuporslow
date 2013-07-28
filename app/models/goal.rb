class Goal < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :workout_template

  attr_accessible :exercise, :exercise_id, :time, :workout_template
end
