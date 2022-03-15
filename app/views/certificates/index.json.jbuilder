json.data @certificates do |certificate|
	json.course certificate.course
	json.student certificate.student
	json.finish_date certificate.start_date.strftime('%d-%m-%y')
	json.actions "#{link_to '<i class="fa fa-file"></i>'.html_safe, mostrar_pdf_path(certificate.id), 
      							'class' => 'btn btn-sm btn-info', title: 'Mostrar PDF', target: '_blank'}"
end
