json.data @students do |student|
	json.legajo student.legajo
	json.name student.name
	json.lastname student.lastname
	json.dni student.dni
	json.email student.email
	json.phone student.phone
	json.country student.country
	json.company student.company.name
	json.actions "#{link_to '<i class="fa fa-eye"></i>'.html_safe, student_path(student), 
										:remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-student', 
      							'class' => 'btn btn-sm btn-primary', title: 'Detalle'}
								#{link_to '<i class="fa fa-pencil-square-o"></i>'.html_safe, edit_student_path(student), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-student', 
      							'class' => 'btn btn-sm btn-warning', title: 'Editar'}
  							<a class='btn btn-sm btn-danger' 
  								title='Eliminar' 
  								onclick='modal_disable_student( #{ student.id } )'>
									<i class='fa fa-trash' aria-hidden='true'></i></a>"
end
