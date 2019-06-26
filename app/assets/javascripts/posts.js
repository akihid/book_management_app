$(document).on('change', '#post_publication_id', function() {
  return $.ajax({
    type: 'GET',
    url: '/posts/book_image',
    data: {
      publication_id: $(this).val()
    }
  }).done(function(data) {
    return $('.book_image').html(data);
  });
});