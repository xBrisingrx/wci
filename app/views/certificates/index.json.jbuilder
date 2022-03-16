json.data @certificates do |certificate|
	json.course certificate.course
	json.student certificate.student
	json.dni certificate.dni
	json.finish_date certificate.start_date.strftime('%d/%m/%Y')
	json.actions "#{link_to '<i class="fa fa-file"></i>'.html_safe, mostrar_pdf_path(certificate.id), 
      							'class' => 'btn btn-sm btn-info', title: 'Mostrar PDF', target: '_blank'}
      							#{link_to '<i class="fa fa-eye"></i>'.html_safe, certificate_path(certificate.id), 
      							'class' => 'btn btn-sm btn-primary', title: 'Información certificado'}
      							<button class='btn btn-sm btn-danger' 
		  								title='Eliminar' 
		  								onclick='modal_disable_certificate( #{ certificate.id } )'>
											<i class='fa fa-trash' aria-hidden='true'></i></button>"
end
