json.data @course_students do |course|
	json.student "#{course.student.fullname}"
	json.inscription_date course.created_at.strftime('%d-%m-%Y')
	json.status @status[course.status]
	json.actions "#{link_to '<i class="fa fa-check-square-o"></i>'.html_safe, get_retest_student_path(course, params[:id]), 
										:remote => true,
      							'class' => 'btn btn-sm btn-info', title: 'Calificaciones'}
								#{link_to '<i class="fa fa-eye"></i>'.html_safe, course_path(course), 
										:remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-course', 
      							'class' => 'btn btn-sm btn-primary', title: 'Detalle'}"
end
