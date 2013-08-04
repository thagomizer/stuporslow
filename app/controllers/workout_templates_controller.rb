class WorkoutTemplatesController < ApplicationController
  def index
    @workout_templates = WorkoutTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workout_templates }
    end
  end

  def new
    @workout_template         = WorkoutTemplate.new
    @workout_template.goals   = []
    @workout_template.athlete = current_athlete

    6.times do
      @workout_template.goals << Goal.new(:workout_template => @workout_template)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workout_template }
    end
  end

  def create
    @workout_template = WorkoutTemplate.new(params[:workout_template])

    @workout_template.goals.delete_if do |g|
      g.time.blank?
    end

    respond_to do |format|
      if @workout_template.save
        format.html { redirect_to @workout_template, notice: 'Workout template was successfully created.' }
        format.json { render json: @workout_template, status: :created, location: @workout_template }
      else
        format.html { render action: "new" }
        format.json { render json: @workout_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @workout_template = WorkoutTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workout_template }
    end
  end

  def edit
    @workout_template = WorkoutTemplate.find(params[:id])
  end

  # PUT /workout_templates/1
  # PUT /workout_templates/1.json
  def update
    @workout_template = WorkoutTemplate.find(params[:id])

    respond_to do |format|
      if @workout_template.update_attributes(params[:workout_template])
        format.html { redirect_to @workout_template, notice: 'Workout template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workout_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workout_templates/1
  # DELETE /workout_templates/1.json
  def destroy
    @workout_template = WorkoutTemplate.find(params[:id])
    @workout_template.destroy

    respond_to do |format|
      format.html { redirect_to workout_templates_url }
      format.json { head :no_content }
    end
  end
end
