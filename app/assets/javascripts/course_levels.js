let course_levels_table

function modal_disable_course_level(id) {
  $('#modal-disable-course-level #course_level_id').val(id)
  $('#modal-disable-course-level').modal('show')
}

$(document).ready(function(){
	course_levels_table = $("#course_levels_table").DataTable({
    'ajax':'course_levels',
    'columns': [
	    {'data': 'name'},
      {'data': 'comment'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
	})

  $("#form-disable-course-level").on("ajax:success", function(event) {
    course_levels_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-course-level").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })

}) // End $(document).ready()