class WorkoutsController < ApplicationController
  before_filter :authenticate_athlete!

  # GET /workouts
  # GET /workouts.json
  def index
    @workouts = Workout.where(:athlete_id => current_athlete.id)
    @templates = WorkoutTemplate.where(:athlete_id => current_athlete.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workouts }
    end
  end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
    @workout = Workout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workout }
    end
  end

  # GET /workouts/new
  # GET /workouts/new.json
  def new
    if params[:template_id]
      @workout_template = WorkoutTemplate.find(params[:template_id])
      @workout = Workout.new_from_template(@workout_template)
    else
      @workout = Workout.default_workout
    end
    @workout.athlete = current_athlete
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workout }
    end
  end

  # GET /workouts/1/edit
  def edit
    @workout = Workout.find(params[:id])
  end

  # POST /workouts
  # POST /workouts.json
  def create
    @workout = Workout.new(params[:workout])

    @workout.athlete ||= current_athlete

    respond_to do |format|
      if @workout.save
        format.html { redirect_to @workout, notice: 'Workout was successfully created.' }
        format.json { render json: @workout, status: :created, location: @workout }
      else
        format.html { render action: "new" }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workouts/1
  # PUT /workouts/1.json
  def update
    @workout = Workout.find(params[:id])

    respond_to do |format|
      if @workout.update_attributes(params[:workout])
        format.html { redirect_to @workout, notice: 'Workout was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.json
  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy

    respond_to do |format|
      format.html { redirect_to workouts_url }
      format.json { head :no_content }
    end
  end
end
