class CourseLevelsController < ApplicationController
  before_action :set_course_level, only: %i[ show edit update destroy ]
  before_action :set_active_menu, only: %i[ index ]

  # GET /course_levels or /course_levels.json
  def index
    @course_levels = CourseLevel.where(active:true)
    @breadcrumbs = [
      [ :name =>'Cursos', :path => courses_path],
      [ :name =>'Niveles', :path => course_levels_path] 
    ]
  end

  # GET /course_levels/1 or /course_levels/1.json
  def show
  end

  # GET /course_levels/new
  def new
    @title_modal = 'Nuevo nivel de curso'
    @course_level = CourseLevel.new
  end

  # GET /course_levels/1/edit
  def edit
    @title_modal = 'Editar nivel de curso'
  end

  # POST /course_levels or /course_levels.json
  def create
    @course_level = CourseLevel.new(course_level_params)

    respond_to do |format|
      if @course_level.save
        format.json { render json: { status: 'success', msg: 'Curso registrado' }, status: :created }
      else
        format.json { render json: @course_level.errors , status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_levels/1 or /course_levels/1.json
  def update
    respond_to do |format|
      if @course_level.update(course_level_params)
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok, location: @course_level }
      else
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

  def disable
    @course_level = CourseLevel.find(params[:course_level][:id])
    if @course_level.update!(active: false)
      render json: { status: 'success', msg: 'Curso eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_level
      @course_level = CourseLevel.find(params[:id])
    end

    def set_active_menu
      @nav_active = [:clients=> '', :courses=> 'active', :programs=> '']
    end

    # Only allow a list of trusted parameters through.
    def course_level_params
      params.require(:course_level).permit(:name, :comment)
    end
end
