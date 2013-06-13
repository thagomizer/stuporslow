class AddWorkoutToLift < ActiveRecord::Migration
  def change
    add_column :lifts, :workout_id, :integer
  end
end
