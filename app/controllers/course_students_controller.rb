class CourseStudentsController < ApplicationController
  before_action :set_course_student, only: %i[ edit update destroy get_notes_student show_certification certificado_wci get_notes_student_retest ]
  before_action :set_name_enums, only: %i[ show get_student_retest ]
  before_action :set_active_menu, only: %i[ show show_certification ]
  skip_before_action :no_login, only: %i[ show_certification  ]

  # GET /course_students or /course_students.json
  def index
    redirect_to courses_path
  end

  # GET /course_students/1 or /course_students/1.json
  def show
    @breadcrumbs = [
        [ :name =>'Cursos', :path => courses_path],
        [ :name =>'Inscripciones', :path => '']
      ]
    @course = Course.select('id, finish_date, program_id, course_type_id').find(params[:id])
    @program = Program.select('name').find(@course.program_id)
    @course_students = CourseStudent.where(active: true,course_id: params[:id]).includes(:student)
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
                                    .where(course_students: {retest_pending: true})
                                    .where('course_students.final_grade >= 60')
                                    .where('course_students.final_grade_date <= ?', limit_date) 
                                      .includes(:student)
  end

  # GET /course_students/new
  def new
    @course_student = CourseStudent.new
    @course_student.course_id = params[:course_id]
    @students = Student.where(active: true).order(:lastname)
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

      if course_student_params[:final_grade].to_i.between?(50,69)
        # Si desaprueba y esta entre los valores para poder hacer retest lo ponemos como pendiente de retest
        @course_student.retest_pending = true
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

          generar_pdf @course_student
          
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
    @course_student = CourseStudent.find(params[:course_students][:id])
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

    # if !params[:course_retest_id].nil?
    #   course = Course.find(params[:course_retest_id])
    #   @fecha_retest_examen = course.finish_date
    #   @retest_id = course.id
    # end

    @fecha_final_curso = @course_student.course.finish_date
    if @course_student.final_grade.between?(50,69)
      if (limit_date > Date.today)
        @msg_badge = "Tiene tiempo de recuperar hasta la fecha #{limit_date.strftime('%d-%m-%Y')}"
        @puede_recuperar = true
      else
        @msg_badge = "Caduco el tiempo para recuperar"
      end
    end
  end

  def get_notes_student_retest
    @title_modal = 'Cargar notas de retest'
    @render = 'form_certifications_retest'
    limit_date = @course_student.course.finish_date + 45.days
    @puede_recuperar = false

    # Este el el curso en donde recuperamos 
    course = Course.find(params[:course_retest_id])
    @fecha_retest_examen = course.finish_date
    @course_id = course.id
    @fecha_final_curso = @course_student.course.finish_date

    if @course_student.final_grade.between?(50,69)
      if (limit_date > Date.today)
        @msg_badge = "Tiene tiempo de recuperar hasta la fecha #{limit_date.strftime('%d-%m-%Y')}"
        @puede_recuperar = true
      else
        @msg_badge = "Caduco el tiempo para recuperar"
      end
    end
  end

  def create_course_student_retest
  if params[:remedial_exam_note].to_i == 0
    return render json: { 'status' => 'noChanges', 'msg' => '' }
  end
  course_student = CourseStudent.find(params[:course_student_id])
    course_student_retest = CourseStudent.new(
     student_id: course_student.student_id,
     course_id: params[:course_id],
     remedial_course_id: course_student.course.id,
     simulation_grade: params[:simulation_grade].to_i,
     simulation_grade_date: params[:simulation_grade_date],
     simulation_bh_grade: params[:simulation_bh_grade].to_i,
     simulation_bh_grade_date: params[:simulation_bh_grade_date],
     simulation_inv_grade: params[:simulation_inv_grade].to_i,
     simulation_inv_grade_date: params[:simulation_inv_grade_date],
     final_grade: course_student.final_grade, 
     final_grade_date: course_student.final_grade_date,
     remedial_exam_note: params[:remedial_exam_note],
     remedial_exam_note_date: params[:remedial_exam_note_date],
     status: (params[:remedial_exam_note].to_i >= 70) ? :pass : :no_pass,
     is_retest: true,
     retest_pending: false )
    
    respond_to do |format|
      if course_student_retest.save! && course_student.update!(retest_pending: false)
        if course_student_retest.pass?
          generar_pdf course_student_retest
        end
        format.json { render json: { 'status' => 'success', 'msg' => 'Retest registrado' }, status: :ok}
      else
        format.json { render json: { 'status' => 'error', 'msg' => 'No se pudo registrar el retest' }, status: :unprocessable_entity}
      end # save
    end # respond to

    rescue => e
      raise_message = e.message.split(':')
      resp = raise_message[1].split(', ')
      @response = Hash.new

      resp.each do |msg|
        @response[msg.split.first.downcase] = msg.split(' ')[1..-1].join(' ')
      end
      
      render json: @response, status: 402
  end
 

  def certificado_wci
    respond_to do |format|
      if File.exist?( Rails.root.join("app/assets/images/certificates/students/#{ @course_student.id}/certificado_qr.pdf" ) )
        format.pdf do
            send_file( Rails.root.join("app/assets/images/certificates/students/#{ @course_student.id}/certificado_qr.pdf"), 
                       filename: 'certificado.pdf', type: 'application/pdf', disposition: 'attachment')
        end
      else
        format.pdf do 
          generar_pdf @course_student
          send_file( Rails.root.join("app/assets/images/certificates/students/#{ @course_student.id}/certificado_qr.pdf"), 
                       filename: 'certificado.pdf', type: 'application/pdf', disposition: 'attachment')
        end
      end
    end #respond todata
  end #certificado wci

  def show_certification
    @vencimiento = @course_student.course.finish_date + 2.years
    @breadcrumbs = [
        [ :name =>'Cursos', :path => courses_path],
        [ :name =>'Inscripciones', :path => course_student_path(@course_student.course_id)],
        [ :name =>'Certificado', :path => '']
      ]
  end


  def generar_pdf course_student
    id = course_student.id
    dir = Rails.root.join("app/assets/images/certificates/students/#{ course_student.id}")
    n_certificado = course_student.course.program.certificate

    generar_qr(id,dir)
    certificado = Rails.root.join("app/assets/images/certificates/certificados/certificado0#{n_certificado}.pdf")

    if course_student.remedial_course_id.nil?
      #aprobo a la primera
      fecha = course_student.course.finish_date
    else
      # aprobo en retest
      fecha = Course.find( course_student.remedial_course_id ).finish_date
    end

    vencimiento = fecha + 2.years
    program_code = course_student.course.program.code.split('-').last 
    dni_student = course_student.student.dni 

    data = {
      'n_certificado' => "WC-#{dni_student}-#{program_code}",
      'N de Programa' => course_student.course.program.code,
      'Proveedor' => 'Well Control International',
      'Fecha de Finalizacion' => fecha.strftime('%d-%m-%Y'),
      'Fecha de Vencimiento' => vencimiento.strftime('%d-%m-%Y'),
      'Presencial' => course_student.course.course_type.name
    }

    pdftk = PdfForms.new('/usr/bin/pdftk', :data_format => 'FdfHex', :utf8_fields => true)

    pdftk.get_field_names "#{certificado}"
    fields_names_form = pdftk.get_field_names "#{certificado}"

    pdftk.fill_form "#{certificado}", "#{dir}/#{id}.pdf", data , :flatten => true
    
    doc = HexaPDF::Document.open("#{dir}/#{id}.pdf")
    page = doc.pages[0]

    canvas = page.canvas(type: :overlay)
    canvas.image(File.join("#{dir}", 'qr_url.png'), at: [350, 50], height: 100)

    canvas.font('Helvetica', size: 14).text(course_student.course.program.name, at: [58, 382])
    canvas.font('Helvetica', size: 14).text(course_student.course.teacher.name, at: [327, 330])

    tf = HexaPDF::Layout::TextFragment.create( course_student.student.fullname,
                                            font: doc.fonts.add("Helvetica"), font_size: 16)
    tl = HexaPDF::Layout::TextLayouter.new

    tl.style.align(:center).valign(:center)
    tl.fit([tf], 495, 17).draw(canvas, 58, 445)
    canvas.stroke_color(0, 0, 0).rectangle(58, 431, 495, 30)

    page2 = doc.pages[1]
    canvas2 = page2.canvas(type: :overlay)
    canvas2.image( File.join( "#{dir}", 'qr_url.png' ), at: [220, 620], height: 80)
    canvas2.font('Helvetica', size: 8).text("#{course_student.student.fullname}", at: [345, 717])
    canvas2.font('Helvetica', size: 8).text(course_student.course.program.name, at: [340, 700])
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
      Dir.mkdir( dir )
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

    def set_active_menu
      @nav_active = [:clients=> '', :courses=> 'active', :programs=> '']
    end

    def course_student_params
      params.require(:course_student).permit(:simulation_grade,:simulation_grade_date, :simulation_bh_grade, :simulation_bh_grade_date,
       :simulation_inv_grade,:simulation_inv_grade_date,:final_grade,:final_grade_date,:remedial_exam_note,:remedial_exam_note_date,
       :status,:comment,:active,:student_id, :course_id, :remedial_course_id)
    end
end
