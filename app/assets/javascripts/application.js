//= require jquery
//= require jquery_ujs
//= require moment
//= require lodash
//= require bootstrap-sprockets
//= require sweetalert2
//= require sweet-alert2-rails
//= require turbolinks
//= require infinite_scrolling
//= require picker
//= require picker.date
//= require picker.time


$(function() {
  $(".member").hover(function(e) {
    let memberId = $(this).attr('data-member-id');
    $(".member-details." + memberId).fadeToggle();
  });
})
