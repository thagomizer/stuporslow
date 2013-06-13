class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :exercise_id
      t.integer :athlete_id
      t.integer :time

      t.timestamps
    end
  end
end
