let certificates_table

function modal_disable_course(id) {
  console.info('cursito')
  $('#modal-disable-course #course_id').val(id)
  $('#modal-disable-course').modal('show')
}

$(document).ready(function(){
	certificates_table = $("#certificates-table").DataTable({
    'ajax':'certificates',
    'columns': [
	    {'data': 'course'},
	    {'data': 'student'},
      {'data': 'finish_date'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
	})

  $("#form-disable-course").on("ajax:success", function(event) {
    certificates_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-course").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })
}) // End $(document).ready()