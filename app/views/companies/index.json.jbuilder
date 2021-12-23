json.data @companies do |company|
	json.name "#{company.name}"
	json.cuit company.cuit
	json.email company.email
	json.actions "#{link_to '<i class="fa fa-users"></i>'.html_safe, students_company_path(company.id), 
      							'class' => 'btn btn-sm u-btn-purple', title: 'Alumnos de esta empresa'}
								#{link_to '<i class="fa fa-eye"></i>'.html_safe, company_path(company), 
										:remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-company', 
      							'class' => 'btn btn-sm btn-primary', title: 'Detalle'}
								#{link_to '<i class="fa fa-pencil-square-o"></i>'.html_safe, edit_company_path(company), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-company', 
      							'class' => 'btn btn-sm btn-warning', title: 'Editar'}
  							<a class='btn btn-sm btn-danger' 
  								title='Eliminar' 
  								onclick='modal_disable_company( #{ company.id } )'>
									<i class='fa fa-trash' aria-hidden='true'></i></a>"
end
