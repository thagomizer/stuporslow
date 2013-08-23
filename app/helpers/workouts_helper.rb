module WorkoutsHelper
  def lifts_by_exercise
    workouts = Workout.where(:athlete_id => current_athlete.id).includes(:lifts)
    lifts = workouts.map { |workout| workout.lifts }.flatten
    lifts_by_exercise = lifts.group_by { |lift| lift.exercise }
  end

  def style pct
    case
    when pct > 1.1 then
      "color: green"
    when pct < 0.9 then
      "color: red; font-weight: bold"
    else
      ""
    end
  end
end
