class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.text :notes
      t.datetime :date
      t.integer :athlete_id

      t.timestamps
    end
  end
end
