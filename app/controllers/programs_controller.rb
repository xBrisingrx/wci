class ProgramsController < ApplicationController
  before_action :set_program, only: %i[ show edit update destroy ]

  # GET /programs or /programs.json
  def index
    @programs = Program.where(active: true)
  end

  # GET /programs/1 or /programs/1.json
  def show
    @title_modal = 'Detalle del programa programa'
  end

  # GET /programs/new
  def new
    @title_modal = 'Nuevo programa'
    @program = Program.new
  end

  # GET /programs/1/edit
  def edit
    @title_modal = 'Editar programa'
  end

  # POST /programs or /programs.json
  def create
    @program = Program.new(program_params)

    respond_to do |format|
      if @program.save
        format.json { render json: { status: 'success', msg: 'Programa registrado' }, status: :created }
      else
        # format.json { render json: @program.errors, status: :unprocessable_entity }
        format.json { render json: @program.errors , status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1 or /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        # format.html { redirect_to @program, notice: "Program was successfully updated." }
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok, location: @program }
      else
        # format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1 or /programs/1.json
  def destroy
    @program.destroy
    respond_to do |format|
      format.html { redirect_to programs_url, notice: "Program was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @program = Program.find(params[:program][:id])
    if @program.update!(active: false)
      render json: { status: 'success', msg: 'Programa eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def program_params
      params.require(:program).permit(:code, :name, :comment, :certificate, :active)
    end
end
