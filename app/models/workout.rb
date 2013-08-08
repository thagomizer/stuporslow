class Workout < ActiveRecord::Base
  belongs_to :athlete
  has_many :lifts

  attr_accessible :athlete, :date, :notes, :lifts_attributes

  accepts_nested_attributes_for :lifts

  def self.new_from_template(workout_template = nil)
    workout         = Workout.new
    workout.lifts   = []

    workout_template.goals.each do |goal|
      workout.lifts << Lift.new(:workout => workout,
                                :exercise => goal.exercise,
                                :time => goal.time)
    end
    workout
  end

  def self.default_workout
    workout = Workout.new
    6.times do
      workout.lifts << Lift.new(:workout => @workout)
    end
    workout
  end
end
