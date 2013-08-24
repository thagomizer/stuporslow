class Array
  def avg
    compacted_array = self.compact
    return if compacted_array.empty?
    compacted_array.sum / compacted_array.length
  end
end

class VisualizeController < ApplicationController
  before_filter :authenticate_athlete!

  def graph
    @dates = Workout.dates_for_athlete(current_athlete)
    @date_labels = @dates.map { |d| d.strftime("%m/%d") }
    @exercise_data = []
    Workout.exercises_for_athlete(current_athlete).each do |exercise|
      lifts = Lift.all_with_athlete_exercise(current_athlete, exercise)
      goal = Goal.where(:exercise_id => exercise.id).
                  joins(:workout_template).
                  where("workout_templates.athlete_id" => current_athlete.id).
                  first

      exercise_data = ::ExerciseData.new
      exercise_data.exercise = exercise
      exercise_data.goal = goal
      exercise_data.dates = @dates

      @dates.each do |date|
        lift = lifts.find { |l| l.workout.date == date }

        if lift
          exercise_data.weights   << lift.weight
          exercise_data.raw_times << lift.time
        else
          exercise_data.weights   << nil
          exercise_data.raw_times << nil
        end

        if goal && lift
          exercise_data.rel_times << lift.time - goal.time
        else
          exercise_data.rel_times << nil
        end

      end
      exercise_data.overall_average = exercise_data.raw_times.avg
      exercise_data.last_10_average = exercise_data.raw_times.first(10).avg
      exercise_data.last_3_average  = exercise_data.raw_times.first(3).avg

      @exercise_data << exercise_data
    end

    @max = 11
  end
end
