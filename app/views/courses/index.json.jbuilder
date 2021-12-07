json.data @courses do |course|
	json.code course.program.code
	json.name course.program.name
	json.start_date (course.start_date) ? course.start_date.strftime('%d-%m-%y') : ''
	json.finish_date (course.finish_date) ? course.finish_date.strftime('%d-%m-%y') : ''
	json.start_hour (course.start_hour) ? course.start_hour.strftime('%H:%M') : ''
	json.finish_hour (course.finish_hour) ? course.finish_hour.strftime('%H:%M') : ''
	json.teacher "#{course.teacher.name}"
	json.modo course.course_type.name
	json.level course.course_level.name
	json.actions "#{link_to '<i class="fa fa-users"></i>'.html_safe, course_student_path(id: course.id), 
      							'class' => 'btn btn-sm btn-info', title: 'Agregar alumnos'}
								#{link_to '<i class="fa fa-eye"></i>'.html_safe, course_path(course), 
										:remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-course', 
      							'class' => 'btn btn-sm btn-primary', title: 'Detalle'}
								#{link_to '<i class="fa fa-pencil-square-o"></i>'.html_safe, edit_course_path(course), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-course', 
      							'class' => 'btn btn-sm btn-warning', title: 'Editar'}
  							<a class='btn btn-sm btn-danger' 
  								title='Eliminar' 
  								onclick='modal_disable_course( #{ course.id } )'>
									<i class='fa fa-trash' aria-hidden='true'></i></a>"
end
