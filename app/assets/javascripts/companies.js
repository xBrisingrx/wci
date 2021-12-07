let companies_table

function modal_disable_company(id) {
  $('#modal-disable-company #company_id').val(id)
  $('#modal-disable-company').modal('show')
}

$(document).ready(function(){
	companies_table = $("#companies-table").DataTable({
    'ajax':'companies',
    'columns': [
	    {'data': 'name'},
	    {'data': 'cuit'},
	    {'data': 'email'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables/datatables_lang_spa.json"}
	})

  $("#form-disable-company").on("ajax:success", function(event) {
    companies_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-company").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    noty_alert(msg.status, msg.msg)
  })

}) // End $(document).ready()