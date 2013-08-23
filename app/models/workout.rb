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

  def remove_empty_lifts
    self.lifts.delete_if { |lift| lift.weight.nil? }
  end

  # TODO optimize this
  def self.exercises_for_athlete(athlete)
    workouts = Workout.for_athlete(athlete).includes(:lifts)

    workouts.map { |w| w.lifts.map { |l| l.exercise }}.flatten.uniq
  end

  def self.dates_for_athlete(athlete)
    Workout.for_athlete(athlete).select(:date)
  end

  def self.last_n_for_athlete(n, athlete)
    Workout.for_athlete(athlete).order("date desc").limit(n)
  end

  # TODO optimize this
  def self.for_athlete_with_exercise_type(athlete, exercise_name)
    workouts = Workout.for_athlete(athlete).includes(:lifts)

    workouts.find_all { |w| w.lifts.any? { |e| e.exercise.name == exercise_name}}
  end

  # TODO optimize this (should be able get just the lift fields)
  def self.all_lifts_of_type_for_athlete(exercise_name, athlete)
    exercise = Exercise.find_by_name(exercise_name)
    workouts = Workout.for_athlete(athlete).includes(:lifts)
    lifts = workouts.map { |w| w.lifts }.flatten
    lifts.select { |l| l.exercise == exercise }
  end
end
