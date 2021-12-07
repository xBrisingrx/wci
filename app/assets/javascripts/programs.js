let programs_table

function modal_disable_program(id) {
  $('#modal-disable-program #program_id').val(id)
  $('#modal-disable-program').modal('show')
}

$(document).ready(function(){
	programs_table = $("#programs-table").DataTable({
    'ajax':'programs',
    'columns': [
	    {'data': 'code'},
	    {'data': 'name'},
      {'data': 'certificate'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
	})

  $("#form-disable-program").on("ajax:success", function(event) {
    programs_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-program").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })

}) // End $(document).ready()