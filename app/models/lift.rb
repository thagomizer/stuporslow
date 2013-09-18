class Lift < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :workout


  attr_accessible :exercise, :exercise_id, :notes, :time, :weight, :workout

  def self.all_with_athlete_exercise(athlete, exercise)
    lifts = Lift.where(:exercise_id => exercise.id).includes(:workout)

    lifts.find_all { |l| l.workout.athlete = athlete }
  end

  def date
    self.workout.date
  end
end
