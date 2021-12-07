let teachers_table

function modal_disable_teacher(id) {
  $('#modal-disable-teacher #teacher_id').val(id)
  $('#modal-disable-teacher').modal('show')
}

$(document).ready(function(){
	teachers_table = $("#teachers-table").DataTable({
    'ajax':'teachers',
    'columns': [
	    {'data': 'name'},
	    {'data': 'dni'},
	    {'data': 'email'},
	    {'data': 'phone'},
      {'data': 'title'},
	    {'data': 'country'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
	})

  $("#form-disable-teacher").on("ajax:success", function(event) {
    teachers_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-teacher").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })

}) // End $(document).ready()