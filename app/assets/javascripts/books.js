$(document).ready(function() {
  $('.x-get-book-info-from-google-books').on('click', function(e) {
    var isbn = $('.x-isbn').find('input').val();

    var request = $.ajax({
      url: "/google-isbn",
      method: "GET",
      data: { isbn : isbn },
      dataType: "json"
    });

    request.done(function( response ) {
      $('.x-published-date').find('input').val(response.publishedDate);
      $('.x-title').find('input').val(response.title);
      $('.x-page-count').find('input').val(response.pageCount);
    });
    request.fail(function( jqXHR, textStatus ) {
      alert( "Request failed: " + textStatus );
    });
    e.preventDefault();
  });
});
