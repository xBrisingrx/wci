json.data @teachers do |teacher|
	json.name teacher.name
	json.dni teacher.dni
	json.email teacher.email
	json.phone teacher.phone
	json.title teacher.title
	json.country teacher.country
	json.actions "#{link_to '<i class="fa fa-eye"></i>'.html_safe, teacher_path(teacher), 
										:remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-teacher', 
      							'class' => 'btn btn-sm btn-primary', title: 'Detalle'}
								#{link_to '<i class="fa fa-pencil-square-o"></i>'.html_safe, edit_teacher_path(teacher), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-teacher', 
      							'class' => 'btn btn-sm btn-warning', title: 'Editar'}
  							<a class='btn btn-sm btn-danger' 
  								title='Eliminar' 
  								onclick='modal_disable_teacher( #{ teacher.id } )'>
									<i class='fa fa-trash' aria-hidden='true'></i></a>"
end
