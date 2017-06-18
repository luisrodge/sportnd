$(function() {
    if ($(window).width() < 790) {
      $('.row').removeClass('gutter-60');
      $('.row').removeClass('gutter-70');
      $('.row').removeClass('gutter-100');
      $('.row').addClass('gutter-30');
    }
});
