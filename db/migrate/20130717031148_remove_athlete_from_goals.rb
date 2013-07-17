class RemoveAthleteFromGoals < ActiveRecord::Migration
  def change
    remove_column :goals, :athlete_id
  end
end
