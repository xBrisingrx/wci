class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  # GET /companies or /companies.json
  def index
    @companies = Company.where(active: true)
  end

  # GET /companies/1 or /companies/1.json
  def show
    @title_modal = "Datos de #{@company.name}"
    @render = 'show'
  end

  # GET /companies/new
  def new
    @title_modal = 'Nuevo cliente'
    @company = Company.new
    @render = 'form'
  end

  # GET /companies/1/edit
  def edit
    @title_modal = 'Editar cliente'
    @render = 'form'
  end

  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.json { render json: {status: 'success', msg: 'Cliente creado'}, status: :created, location: @company }
        format.html { redirect_to @company, notice: "Company was successfully created." }
      else
        format.json { render json: @company.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.json { render json: {status: 'success', msg: 'Datos actualizados'}, status: :ok, location: @company }
        format.html { redirect_to @company, notice: "Company was successfully updated." }
      else
        format.json { render json: @company.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @company = Company.find(params[:company][:id])
    if @company.update!(active: false)
      render json: { status: 'success', msg: 'Cliente eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :cuit, :email, :active)
    end
end
