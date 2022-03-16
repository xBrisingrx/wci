let courses_table

function modal_disable_course(id) {
  $('#modal-disable-course #course_id').val(id)
  $('#modal-disable-course').modal('show')
}

$(document).ready(function(){
	courses_table = $("#courses-table").DataTable({
    'ajax':'courses',
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

  $("#form-disable-course").on("ajax:success", function(event) {
    courses_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-course").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })
}) // End $(document).ready()