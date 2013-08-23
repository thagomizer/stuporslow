module WorkoutsHelper
  def lifts_by_exercise
    workouts = Workout.where(:athlete_id => current_athlete.id).includes(:lifts)
    lifts = workouts.map { |workout| workout.lifts }.flatten
    lifts_by_exercise = lifts.group_by { |lift| lift.exercise }
  end
end
