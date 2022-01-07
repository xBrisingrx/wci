let courses_finished_table

$(document).ready(function(){
	courses_finished_table = $("#courses-finished-table").DataTable({
    'ajax':'cursos_finalizados',
    'columns': [
	    {'data': 'code'},
	    {'data': 'name'},
	    {'data': 'start_date'},
	    {'data': 'finish_date'},
	    {'data': 'start_hour'},
			{'data': 'finish_hour'},
			{'data': 'teacher'},
			{'data': 'level'},
      {'data': 'modo'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
	})
}) // End $(document).ready()