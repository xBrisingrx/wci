class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy student_courses ]
  before_action :set_active_menu, only: %i[ index students_company student_courses ]

  # GET /students or /students.json
  def index
    @students = Student.where(active:true)
    @breadcrumbs = [
      [ :name =>'Clientes', :path => students_path],
      [ :name =>'Alumnos', :path => students_path] 
    ]
  end

  def students_company
    @company = Company.find(params[:company_id])
    @students = @company.students
    @breadcrumbs = [
      [ :name =>'Empresas', :path => companies_path],
      [ :name =>"Cursos a los que se inscribio el alumno #{@company.name}", :path => students_path] 
    ]
  end

  def student_courses
    @courses = CourseStudent.where(student_id: params[:id]).order(:id)
    @status = { 'pending' => 'En curso', 'pass' => 'Aprobado', 'no_pass' => 'Desaprobado', 'absent' => 'Ausente'}
    @breadcrumbs = [
      [ :name =>'Clientes', :path => students_path],
      [ :name =>'Alumnos', :path => students_path],
      [ :name =>"Cursos hechos por #{@student.fullname}", :path => '']
    ]
  end

  # GET /students/1 or /students/1.json
  def show
    @title_modal = "Datos de #{@student.fullname}"
    @render = 'show'
  end

  # GET /students/new
  def new
    @student = Student.new
    @countries = Country.all.order(:name)
    @companies = Company.where(active: true).order(:name)
    @title_modal = 'Agregar alumno'
    @render = 'form'
  end

  # GET /students/1/edit
  def edit
    @countries = Country.all.order(:name)
    @companies = Company.where(active: true).order(:name)
    @title_modal = 'Editar alumno'
    @render = 'form'
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.json { render json: { status: 'success', msg: 'Alumno registrado' }, status: :created }
        format.html { redirect_to @student, notice: "Student was successfully created." }
      else
        format.json { render json: @student.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok, location: @student }
        format.html { redirect_to @student, notice: "Student was successfully updated." }
      else
        format.json { render json: @student.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @student = Student.find(params[:student][:id])
    if @student.update!(active: false)
      render json: { status: 'success', msg: 'Alumno eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    def set_active_menu
      @nav_active = [:clients=> 'active', :courses=> '', :programs=> '']
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :birthdate, :lastname, :dni, :email,:phone, :country , :company_id, :active, :legajo, :comment)
    end
end
