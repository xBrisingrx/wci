class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]
  before_action :set_data, only: %i[new edit]

  # GET /courses or /courses.json
  def index
    @courses = Course.where(active: :true)
    @title_modal = 'Alumnos en este curso'
  end

  # GET /courses/1 or /courses/1.json
  def show
    @title_modal = 'Detalles del curso'
    @render = 'show'
  end

  # GET /courses/new
  def new
    @course = Course.new
    @title_modal = 'Agregar curso'
    @render = 'form'
  end

  # GET /courses/1/edit
  def edit
    @title_modal = 'Editar curso'
    @render = 'form'
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.json { render json: {status: 'success', msg: 'Curso creado'}, status: :created, location: @course }
        format.html { redirect_to @course, notice: "Course was successfully created." }
      else
        format.json { render json: @course.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.json { render json: {status: 'success', msg: 'Datos del curso actualizados'}, status: :ok, location: @course }
        format.html { redirect_to @course, notice: "Course was successfully updated." }
      else
        format.json { render json: @course.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    # deshabilitamos el curso y todos los estudiantes inscriptos
    @course = Course.find(params[:course][:id])
    if @course.disable(active: false)
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
    def set_course
      @course = Course.find(params[:id])
    end

    def set_data
      @levels = CourseLevel.where(active: true)
      @type = CourseType.where(active: true)
      @programs = Program.where(active: true)
      @teachers = Teacher.where(active: true)
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:start_date, :finish_date, :start_hour, :finish_hour, :teacher_id, 
                                      :course_level_id, :course_type_id, :program_id, :active, :comment)
    end
end
