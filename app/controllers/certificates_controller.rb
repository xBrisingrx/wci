class CertificatesController < ApplicationController

	def new
		@teachers = Teacher.where(active:true).order(:name)
		@programs = Program.select('id, name, code').where(active:true).order(:name)
		@type = CourseType.where(active: true)
		@title_modal = 'Generar certificado'
    @render = 'form'
	end

	def create
		program = Program.find(params[:program_id])
		certificate = Certificate.new
		finish_date = Date.strptime(params[:finish_date],'%Y-%m-%d')

		certificate.student = params[:student_name]
		certificate.start_date = params[:finish_date]
		certificate.finish_date = finish_date + 2.years
		certificate.teacher = params[:teacher_name]
		certificate.course = program.name
		certificate.program_number = program.code
		certificate.mode = params[:course_type]
		program_code = program.code.split('-').last
		certificate.number = "WC-#{params[:dni]}-#{program_code}"
		certificate.program_id = program.id

		if certificate.save
			generar_pdf( certificate, program.certificate ) 
		end
	end

	def show
		@breadcrumbs = [
        [ :name =>'Cursos', :path => courses_path],
        [ :name =>'Inscripciones', :path => '']
      ]
    @nav_active = [:clients=> '', :courses=> 'active', :programs=> '']
    @certificate = Certificate.find(params[:id])
	end

	def get_certificado
		puts 'get'
	end

  def generar_pdf certificate, n_certificado
    id = certificate.id
    date = Time.new
    pdf_path = "assets/images/certificates/#{date.year}/#{date.month}/#{ certificate.id}"
    certificate.update!(path: pdf_path)

    dir = Rails.root.join("app/#{pdf_path}")

    generar_qr(id,dir)
    certificado = Rails.root.join("app/assets/images/certificates/certificados/certificado0#{n_certificado}.pdf")

    data = {
      'n_certificado' => certificate.number,
      'N de Programa' => certificate.program_number,
      'Proveedor' => 'Well Control International',
      'Fecha de Finalizacion' => certificate.start_date.strftime('%d-%m-%Y'),
      'Fecha de Vencimiento' => certificate.finish_date.strftime('%d-%m-%Y'),
      'Presencial' => certificate.mode
    }

    pdftk = PdfForms.new('/usr/bin/pdftk', :data_format => 'FdfHex', :utf8_fields => true)

    pdftk.get_field_names "#{certificado}"

    pdftk.fill_form "#{certificado}", "#{dir}/#{id}.pdf", data , :flatten => true
    
    doc = HexaPDF::Document.open("#{dir}/#{id}.pdf")
    page = doc.pages[0]

    canvas = page.canvas(type: :overlay)
    canvas.image(File.join("#{dir}", 'qr_url.png'), at: [350, 50], height: 100)

    canvas.font('Helvetica', size: 14).text(certificate.course, at: [58, 382])
    canvas.font('Helvetica', size: 14).text(certificate.teacher, at: [327, 330])

    tf = HexaPDF::Layout::TextFragment.create( certificate.student,
                                            font: doc.fonts.add("Helvetica"), font_size: 16)
    tl = HexaPDF::Layout::TextLayouter.new

    tl.style.align(:center).valign(:center)
    tl.fit([tf], 495, 17).draw(canvas, 58, 445)
    canvas.stroke_color(0, 0, 0).rectangle(58, 431, 495, 30)

    page2 = doc.pages[1]
    canvas2 = page2.canvas(type: :overlay)
    canvas2.image( File.join( "#{dir}", 'qr_url.png' ), at: [220, 620], height: 80)
    canvas2.font('Helvetica', size: 8).text("#{certificate.student}", at: [345, 717])
    canvas2.font('Helvetica', size: 8).text(certificate.course, at: [340, 700])
    doc.write("#{dir}/certificado_qr.pdf", optimize: true)
  end

  def generar_qr id, dir
    url = url_for(action: 'get_certificado', id: id, only_path: false)
    puts "========= URL #{url}"
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
      FileUtils.mkdir_p( dir )
      IO.binwrite("#{dir}/qr_url.png", png.to_s)
    end
  end

end
