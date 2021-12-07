json.data @course_students do |course|
	json.student "#{course.student.name} #{course.student.lastname}"
	json.inscription_date course.created_at.strftime('%d-%m-%Y')
	json.status course.status
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
