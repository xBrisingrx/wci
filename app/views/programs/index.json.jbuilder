json.data @programs do |p|
	json.code p.code
	json.name p.name
	json.certificate p.certificate
	json.actions "#{link_to '<i class="fa fa-eye"></i>'.html_safe, program_path(p), 
										:remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-program', 
      							'class' => 'btn btn-sm btn-primary', title: 'Detalle'}
								#{link_to '<i class="fa fa-pencil-square-o"></i>'.html_safe, edit_program_path(p), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-program', 
      							'class' => 'btn btn-sm btn-warning', title: 'Editar'}
  							<a class='btn btn-sm btn-danger' 
  								title='Eliminar' 
  								onclick='modal_disable_program( #{ p.id } )'>
									<i class='fa fa-trash' aria-hidden='true'></i></a>"
end
