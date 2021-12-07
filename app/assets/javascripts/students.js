let students_table

function modal_disable_student(id) {
  $('#modal-disable-student #student_id').val(id)
  $('#modal-disable-student').modal('show')
}

$(document).ready(function(){
	students_table = $("#students-table").DataTable({
    'ajax':'students',
    'columns': [
	    {'data': 'legajo'},
	    {'data': 'name'},
	    {'data': 'lastname'},
	    {'data': 'dni'},
	    {'data': 'email'},
	    {'data': 'phone'},
	    {'data': 'country'},
	    {'data': 'company'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
	})

  $("#form-disable-student").on("ajax:success", function(event) {
    students_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-student").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })

}) // End $(document).ready()