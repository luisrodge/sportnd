$(function () {
  if (!($('.tournaments.index').length > 0 || $('.teams.index').length > 0 ||
    $('.members.index').length > 0)) {
    return;
  }
  $('.row').removeClass('gutter-70');
  

  var THRESHOLD = 300;
  var $paginationElem = $('.pagination');
  var $window = $(window);
  var $document = $(document);
  var paginationUrl = $paginationElem.attr('data-pagination-endpoint');
  var pagesAmount = $paginationElem.attr('data-pagination-pages');
  var currentPage = 1;
  var baseEndpoint;

  /* validate if the pagination URL has query params */
  if (paginationUrl.indexOf('?') != -1) {
    baseEndpoint = paginationUrl + "&page=";
  } else {
    baseEndpoint = paginationUrl + "?page="
  }

  /* initialize pagination */
  $paginationElem.hide()
  var isPaginating = false

  /* listen to scrolling */
    $window.on('scroll', _.debounce(function () {
      if (!isPaginating && currentPage < pagesAmount && $window.scrollTop() > $document.height() - $window.height() - THRESHOLD) {
        isPaginating = true;
        currentPage++;
        $paginationElem.show();
        $.ajax({
          url: baseEndpoint + currentPage
        }).done(function (result) {
          $('.js-items-container').append(result);
          isPaginating = false;
        });
      }
      if (currentPage >= pagesAmount) {
        $paginationElem.hide();
      }
    }, 100));
});
