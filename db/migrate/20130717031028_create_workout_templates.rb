class CreateWorkoutTemplates < ActiveRecord::Migration
  def change
    create_table :workout_templates do |t|
      t.string :name
      t.integer :athlete_id

      t.timestamps
    end
  end
end
