class Athlete < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :workouts
  has_many :workout_templates

  attr_accessible :first_name, :last_name

  def lifts_for_exercise(exercise)
    Lift.joins(:workout).where('workouts.athlete_id' => self.id, :exercise_id => exercise.id)
  end
end
