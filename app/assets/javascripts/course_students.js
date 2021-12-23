let course_students_table, retest_table, final_grade, remedial_grade

function modal_disable_course_student(id) {
  $('#modal-disable-course-students #course_students_id').val(id)
  $('#modal-disable-course-students').modal('show')
}

function modal_absent_student( id , student_name ) {
  $('#form-absent-students #course_students_id').val(id)
  $('#modal-absent-students #name-student-absent').html('')
  $('#modal-absent-students #name-student-absent').html(`Dejará en estado ausente a <b>${student_name}</b>`)
  $('#modal-absent-students').modal('show')
}



$(document).ready(function(){
	course_students_table = $("#course-students-table").DataTable({
    'ajax':'/course_students/' + $('#course_student_id').val(),
    'columns': [
	    {'data': 'student'},
	    {'data': 'inscription_date'},
	    {'data': 'status'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
	})

  if ( document.getElementById('retest-table') != null ) {
    retest_table = $("#retest-table").DataTable({
      'ajax':'/get_student_retest/' + $('#course_student_id').val(),
      'columns': [
        {'data': 'student'},
        {'data': 'inscription_date'},
        {'data': 'status'},
        {'data': 'actions'}
      ],
      'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
    })
  }
  
  $("#form-disable-course-students").on("ajax:success", function(event) {
    course_students_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-course-students").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })

  $("#form-absent-students").on("ajax:success", function(event) {
    course_students_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-absent-students").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })

}) // End $(document).ready()