class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[ show edit update destroy ]

  # GET /teachers or /teachers.json
  def index
    @teachers = Teacher.where(active:true).order(:name)
  end

  # GET /teachers/1 or /teachers/1.json
  def show
    @title_modal = 'Informacion del instructor'
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
    @countries = Country.all.order(:name)
    @title_modal = 'Agregar instructor'
  end

  # GET /teachers/1/edit
  def edit
    @countries = Country.all.order(:name)
    @title_modal = 'Editar alumno'
  end

  # POST /teachers or /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.json { render json: {status: 'success', msg: 'Instructor registrado'}, location: @teacher }
        format.html { redirect_to @teacher, notice: "Teacher was successfully created." }
      else
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1 or /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.json { render json: {status: 'success', msg: 'Instructor registrado'}, status: :ok, location: @teacher }
        format.html { redirect_to @teacher, notice: "Teacher was successfully updated." }
      else
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1 or /teachers/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: "Teacher was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def disable
    @teacher = Teacher.find(params[:teacher][:id])
    if @teacher.update!(active: false)
      render json: { status: 'success', msg: 'Instructor eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_params
      params.require(:teacher).permit(:name, :dni, :email, :title, :active, :phone, :country)
    end
end
