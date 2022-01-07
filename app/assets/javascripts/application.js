// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage

// === UNIFY
//= require unify/jquery.min
//= require unify/jquery-migrate.min
//= require unify/popper.min
//= require unify/bootstrap.min
//= require unify/hs.core
//= require unify/hs.megamenu
//= require unify/hs.header
//= require unify/hs.hamburgers
// === END UNIFY
// jquery-3.6.0.min
// bootstrap.min

//= require plugins/datatables/datatables.min
//= require plugins/noty/noty.min
//= require plugins/noty/velocity.min
//= require plugins/select2.full.min
//= require programs
//= require students
//= require teachers
//= require courses
//= require courses_finished
//= require course_levels
//= require course_students
//= require companies

// require_tree .

function noty_alert(type, message) {
  var newNoty = new Noty({
    "type": type,
    "layout": "topRight",
    "timeout": 5000,
    "text": `<div>${message}.</div>`,
    "theme": "semanticui"
  }).show();
}

$(window).on('load', function () {
  // initialization of header
  $.HSCore.components.HSHeader.init($('#js-header'));
  $.HSCore.helpers.HSHamburgers.init('.hamburger');

  // initialization of HSMegaMenu component
  $('.js-mega-menu').HSMegaMenu({
    event: 'hover',
    pageContainer: $('.container'),
    breakpoint: 991
  });
});