class CourseLevelsController < ApplicationController
  before_action :set_course_level, only: %i[ show edit update destroy ]

  # GET /course_levels or /course_levels.json
  def index
    @course_levels = CourseLevel.all
  end

  # GET /course_levels/1 or /course_levels/1.json
  def show
  end

  # GET /course_levels/new
  def new
    @course_level = CourseLevel.new
  end

  # GET /course_levels/1/edit
  def edit
  end

  # POST /course_levels or /course_levels.json
  def create
    @course_level = CourseLevel.new(course_level_params)

    respond_to do |format|
      if @course_level.save
        format.html { redirect_to @course_level, notice: "Course level was successfully created." }
        format.json { render :show, status: :created, location: @course_level }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_levels/1 or /course_levels/1.json
  def update
    respond_to do |format|
      if @course_level.update(course_level_params)
        format.html { redirect_to @course_level, notice: "Course level was successfully updated." }
        format.json { render :show, status: :ok, location: @course_level }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_levels/1 or /course_levels/1.json
  def destroy
    @course_level.destroy
    respond_to do |format|
      format.html { redirect_to course_levels_url, notice: "Course level was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_level
      @course_level = CourseLevel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_level_params
      params.require(:course_level).permit(:name)
    end
end
