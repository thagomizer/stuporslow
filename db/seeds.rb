# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


exercises = ["Abdominals",
             "Back Extension",
             "Calf Raise",
             "Chest Press",
             "Compound Row",
             "Leg Curl",
             "Leg Extension",
             "Leg Press",
             "Overhead Press",
             "Pull Down"]

exercises.each do |exercise|
  Exercise.create(:name => exercise)
end
