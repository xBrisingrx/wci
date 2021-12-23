class CourseStudentsController < ApplicationController
  before_action :set_course_student, only: %i[ edit update destroy get_notes_student show_certification certificado_wci ]
  before_action :set_name_enums, only: %i[ show get_student_retest ]
  skip_before_action :no_login, only: %i[ show_certification ]

  # GET /course_students or /course_students.json
  def index
    redirect_to courses_path
  end

  # GET /course_students/1 or /course_students/1.json
  def show
    @course = Course.select('id, finish_date, program_id, course_type_id').find(params[:id])
    @program = Program.select('name').find(@course.program_id)
    @course_students = CourseStudent.where(active: true,course_id: params[:id]).or( CourseStudent.where(remedial_course: params[:id]) ).includes(:student)
    @countries = Country.all.order(:name)
    @companies = Company.where(active: true).order(:name)
  end

  def get_student_retest
    # Obtengo los alumnos que pueden rendir retest en un curso
    course = Course.find(params[:id])
    program_id = course.program.id
    limit_date = course.finish_date + 45.days
    @course_students = CourseStudent.joins( course: [ :program ] )
                                    .where(programs: { id: program_id })
                                    .where.not(course_students: { course_id: params[:id] })
                                    .where(course_students: { active: true })
                                    .where(course_students: {status: :no_pass})
                                      .includes(:student)
  end

  # GET /course_students/new
  def new
    @course_student = CourseStudent.new
    @course_student.course_id = params[:course_id]
    @students = Student.where(active: true)
    @title_modal = 'Inscribir alumno'
    @render = 'form'
  end

  # GET /course_students/1/edit
  def edit
    @render = 'form'
  end

  # POST /course_students or /course_students.json
  def create
    @course_student = CourseStudent.new(course_student_params)

    respond_to do |format|
      if @course_student.save
        format.json { render json: {status: 'success', msg: 'Alumno inscripto'}, status: :created, location: @course_student }
        format.html { redirect_to @course_student, notice: "Course student was successfully created." }
      else
        format.json { render json: @course_student.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  def register_student
    course = Course.find(params[:course_id])
    @course_id = course.id
    @is_presencial = (course.course_type_id == 2) 
    @countries = Country.all.order(:name)
    @companies = Company.where(active: true).order(:name)
    @title_modal = 'Registrar nuevo alumno'
    @render = 'form_create_and_register_student'
  end

  def create_and_register_student
    ActiveRecord::Base.transaction do
      student = Student.new
      student.name = params[:name]
      student.lastname = params[:lastname]
      student.dni = params[:dni]
      student.legajo = params[:legajo]
      student.email = params[:email]
      student.phone = params[:phone]
      student.birthdate = params[:birthdate]
      student.country = params[:country]
      student.company_id = params[:company_id]
      student.comment = params[:comment]
      if student.save!
        student_id = Student.find_by(dni: student.dni)
        course_student = CourseStudent.new(student_id: student_id.id, course_id: params[:course_id])
        if course_student.save!
          render json: {status: 'success', msg: 'Alumno inscripto'}, status: :created
        end
      end
    end

    rescue => e
      raise_message = e.message.split(':')
      resp = raise_message[1].split(', ')
      @response = Hash.new

      # Preparo el hash de mi response, 
      # como key le pongo la primer palabra del string
      # luego de msg le meto el msg de error pero eliminando la primer palabra
      resp.each do |msg|
        @response[msg.split.first.downcase] = msg.split(' ')[1..-1].join(' ')
      end
      
      render json: @response, status: 402
  end

  # PATCH/PUT /course_students/1 or /course_students/1.json
  def update
    @msg = 'Datos actualizados'

    if !course_student_params[:final_grade].nil? && @course_student.final_grade != course_student_params[:final_grade].to_i
      if course_student_params[:final_grade] < '70'
        @course_student.status = 'no_pass'
      end
    end

    if !course_student_params[:remedial_exam_note].nil? && @course_student.remedial_exam_note != course_student_params[:remedial_exam_note].to_i
      if course_student_params[:remedial_exam_note] < '70'
        @course_student.status = 'no_pass'
      end
    end

    respond_to do |format|
      if @course_student.update!(course_student_params)
        if @course_student.status != 'pass' && (@course_student.final_grade > 70 || @course_student.remedial_exam_note > 70)
          # me aseguro que el alumno todavia no haya aprobado asi no repite la accion
          # acciones para alumnos aprobados
          @course_student.update!(status: 1)
          @msg = 'Alumno aprobado, pdf generado'
          dir = Rails.root.join("app/assets/images/certificates/students/#{ @course_student.id}")
          n_certificado = @course_student.course.program.certificate
          generar_pdf @course_student, dir, n_certificado
          
        end # if QR 

        format.json { render json: {status: 'success', msg: @msg}, status: :ok, location: @course_student }
        format.html { redirect_to @course_student, notice: "Course student was successfully updated." }
      else
        format.json { render json: @course_student.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  def destroy
    @course_student.destroy
    respond_to do |format|
      format.html { redirect_to course_students_url, notice: "Course student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @course_student = CourseStudent.find(params[:course_student][:id])
    if @course_student.update!(active: false)
      render json: { status: 'success', msg: 'Alumno eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  def absent_student
    # Actualizams el estado del estudiante a ausente
    @course_student = CourseStudent.find(params[:id])
    if @course_student.update!(status: :absent)
      render json: { status: 'success', msg: 'Estado actualizado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  def get_notes_student
    @title_modal = 'Cargar notas'
    @render = 'form_certifications'
    limit_date = @course_student.course.finish_date + 45.days
    @puede_recuperar = false

    if @course_student.final_grade == 0
      @fecha_nota_examen = @course_student.course.finish_date
    end

    if !params[:course_retest_id].nil?
      course = Course.find(params[:course_retest_id])
      @fecha_retest_examen = course.finish_date
      @retest_id = course.id
    end

    @fecha_final_curso = @course_student.course.finish_date
    if @course_student.final_grade.between?(50,69)
      if (limit_date > Date.today)
        @msg_badge = "Tiene tiempo de recuperar hasta la fecha #{limit_date.strftime('%d-%m-%Y')}"
        @puede_recuperar = true
      else
        @msg_badge = "Caduco el tiempo para recuperar"
      end
    end
    
    # @msg_badge = (limit_date > Date.today) ? "Tiene tiempo de recuperar hasta la fecha #{limit_date.strftime('%d-%m-%Y')}" : "Caduco el tiempo para recuperar"  
  end
 

  def certificado_wci
    respond_to do |format|
      format.pdf do
          send_file( Rails.root.join("app/assets/images/certificates/students/#{ @course_student.id}/certificado_qr.pdf"), 
                     filename: 'certificado.pdf', type: 'application/pdf', disposition: 'attachment')
      end
    end
  end

  def show_certification
    @vencimiento = @course_student.course.finish_date + 2.years
  end

  def generar_pdf course_student,dir, n_certificado
    id = course_student.id
    generar_qr(id,dir)
    certificado = Rails.root.join("app/assets/images/certificates/certificados/certificado0#{n_certificado}.pdf")

    if course_student.remedial_course.nil?
      #aprobo a la primera
      fecha = course_student.course.finish_date
    else
      # aprobo en retest
      fecha = Course.find( course_student.remedial_course ).finish_date
    end

    vencimiento = fecha + 2.years
    program_code = course_student.course.program.code.split('-').last 
    dni_student = course_student.student.dni 

    data = {
      'Nombre del Alumno' => course_student.student.fullname,
      'Nombre del Curso' => course_student.course.program.name,
      'n_certificado' => "WC-#{dni_student}-#{program_code}",
      'Instructor' => course_student.course.teacher.name,
      'N de Programa' => course_student.course.program.code,
      'Proveedor' => 'Well Control International',
      'Fecha de Finalizacion' => fecha,
      'Fecha de Vencimiento' => vencimiento.strftime('%d-%m-%Y'),
      'Presencial' => course_student.course.course_type.name
    }

      pdftk = PdfForms.new('/usr/bin/pdftk')
      pdftk.get_field_names "#{certificado}"
      pdftk.fill_form "#{certificado}", "#{dir}/#{id}.pdf", data, :flatten => true
      
      doc = HexaPDF::Document.open("#{dir}/#{id}.pdf")
      page = doc.pages[0]

      canvas = page.canvas(type: :overlay)
      canvas.image(File.join("#{dir}", 'qr_url.png'), at: [350, 50], height: 100)

      page2 = doc.pages[1]

      canvas2 = page2.canvas(type: :overlay)
      canvas2.image( File.join( "#{dir}", 'qr_url.png' ), at: [220, 620], height: 80)

      doc.write("#{dir}/certificado_qr.pdf", optimize: true)
  end

  def generar_qr id, dir
    url = url_for(action: 'show_certification', id: id, only_path: false)
    # url['localhost'] = 'brisingr.ddns.net'
    # url['localhost'] = "#{ENV['BASE_URL']}"
    qrcode = RQRCode::QRCode.new( url )
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
    if File.exist?( dir )
      IO.binwrite("#{dir}/qr_url.png", png.to_s)
    else
      retorno = Dir.mkdir( dir )
      IO.binwrite("#{dir}/qr_url.png", png.to_s)
    end
  end



  private
    def set_course_student
      @course_student = CourseStudent.find(params[:id])
    end

    # Paso a :es mis enumarados
    def set_name_enums
      @status = { 'pending' => 'En curso', 'pass' => 'Aprobado', 'no_pass' => 'Desaprobado', 'absent' => 'Ausente'}
    end

    def course_student_params
      params.require(:course_student).permit(:simulation_grade,:simulation_grade_date, :simulation_bh_grade, :simulation_bh_grade_date,
       :simulation_inv_grade,:simulation_inv_grade_date,:final_grade,:final_grade_date,:remedial_exam_note,:remedial_exam_note_date,
       :status,:comment,:active,:student_id, :course_id, :remedial_course)
    end
end


