class CreateLifts < ActiveRecord::Migration
  def change
    create_table :lifts do |t|
      t.integer :exercise_id
      t.integer :weight
      t.integer :time
      t.text :notes

      t.timestamps
    end
  end
end
