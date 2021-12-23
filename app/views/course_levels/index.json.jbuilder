json.data @course_levels do |c|
	json.name c.name
	json.comment c.comment
	json.actions "#{link_to '<i class="fa fa-eye"></i>'.html_safe, course_level_path(c), 
										:remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-course_level', 
      							'class' => 'btn btn-sm btn-primary', title: 'Detalle'}
								#{link_to '<i class="fa fa-pencil-square-o"></i>'.html_safe, edit_course_level_path(c), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-course-level', 
      							'class' => 'btn btn-sm btn-warning', title: 'Editar'}
  							<a class='btn btn-sm btn-danger' 
  								title='Eliminar' 
  								onclick='modal_disable_course_level( #{ c.id } )'>
									<i class='fa fa-trash' aria-hidden='true'></i></a>"
end