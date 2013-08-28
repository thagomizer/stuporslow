class Workout < ActiveRecord::Base
  belongs_to :athlete
  has_many :lifts, dependent: :destroy
  before_save :remove_empty_lifts

  attr_accessible :athlete, :date, :notes, :lifts_attributes

  accepts_nested_attributes_for :lifts

  scope :for_athlete, lambda { |athlete| where(:athlete_id => athlete.id) if athlete }

  def self.new_from_template(workout_template = nil, athlete = nil)
    workout         = Workout.new
    workout.lifts   = []

    workout_template.goals.each do |goal|
      weight = 0
      if athlete
        lifts = Lift.all_with_athlete_exercise(athlete, goal.exercise)
        lifts = lifts.sort { |a, b| b <=> a }.last(3).compact
        weight = lifts.find { |x| x.weight }.weight unless lifts.empty?
      end

      workout.lifts << Lift.new(:workout  => workout,
                                :exercise => goal.exercise,
                                :weight   => weight,
                                :time     => goal.time)
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
    Workout.for_athlete(athlete).select(:date).order("date DESC").map(&:date)
  end

  def self.last_n_for_athlete(n, athlete)
    Workout.for_athlete(athlete).order("date desc").limit(n)
  end

  # TODO optimize this
  def self.all_workouts_with_exercise_for_athlete(exercise, athlete)
    workouts = Workout.for_athlete(athlete).includes(:lifts)

    workouts.find_all { |w| w.lifts.any? { |e| e.exercise == exercise }}
  end

  # TODO optimize this (should be able get just the lift fields)
  def self.all_lifts_of_type_for_athlete(exercise_name, athlete)
    exercise = Exercise.find_by_name(exercise_name)
    workouts = Workout.for_athlete(athlete).includes(:lifts)
    lifts = workouts.map { |w| w.lifts }.flatten
    lifts.select { |l| l.exercise == exercise }
  end
end
