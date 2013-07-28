class AddWorkoutTemplateToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :workout_template_id, :integer
  end
end
