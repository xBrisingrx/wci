json.data @course_students do |course|
	json.student "#{course.student.fullname}"
	json.inscription_date course.created_at.strftime('%d-%m-%Y')

	if course.is_retest
		json.status "#{@status[course.status]} <span class='badge bg-info'>retest</span>"
	else
		json.status @status[course.status]
	end

	if course.pending? 
		json.actions "#{link_to '<i class="fa fa-check-square-o"></i>'.html_safe, get_notes_student_path(course), 
										:remote => true,
      							'class' => 'btn btn-sm u-btn-cyan', title: 'Calificaciones'}
      					<a class='btn btn-sm u-btn-yellow' 
  								title='Alumno ausente' 
  								onclick='modal_absent_student( #{ course.id }, `#{course.student.fullname}` )'>
									<i class='fa fa-user-times' aria-hidden='true'></i></a>
  							<a class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_course_student( #{ course.id } )'>
									<i class='fa fa-trash' aria-hidden='true'></i></a>"
	elsif course.pass?
		json.actions "#{link_to '<i class="fa fa-check-square-o"></i>'.html_safe, get_notes_student_path(course), 
										:remote => true,
      							'class' => 'btn btn-sm u-btn-cyan', title: 'Calificaciones'}
								#{link_to '<i class="fa fa-eye"></i>'.html_safe, show_certification_path(course), 
      							'class' => 'btn btn-sm u-btn-yellow', title: 'Ver certificado'}
      					#{link_to '<i class="fa fa-file-pdf-o"></i>'.html_safe, certificado_wci_path(course, format: :pdf), 
      							'class' => 'btn btn-sm u-btn-primary', title: 'Ver PDF', target: '_blank'}"
  else 
  	json.actions "#{link_to '<i class="fa fa-check-square-o"></i>'.html_safe, get_notes_student_path(course), 
										:remote => true,
      							'class' => 'btn btn-sm u-btn-cyan', title: 'Calificaciones'}"
	end
end
