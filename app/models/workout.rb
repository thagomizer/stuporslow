class Workout < ActiveRecord::Base
  belongs_to :athlete
  has_many :lifts
  before_save :remove_empty_lifts

  attr_accessible :athlete, :date, :notes, :lifts_attributes

  accepts_nested_attributes_for :lifts

  scope :for_athlete, lambda { |athlete| where(:athlete_id => athlete.id) if athlete }

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

  # TODO optimize this
  def self.exercise_names_for_athlete(athlete)
    workouts = Workout.for_athlete(athlete).includes(:lifts)

    workouts.map(&:lifts).flatten.map { |l| l.exercise.name }.flatten.uniq
  end

  def self.dates_for_athlete(athlete)
    Workout.for_athlete(athlete).select(:date)
  end

  def remove_empty_lifts
    self.lifts.delete_if { |lift| lift.weight.nil? }
  end
end
