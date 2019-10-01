$(document).on('change', '#post_publication_id', function() {
  return $.ajax({
    type: 'GET',
    url: '/posts/book_image',
    data: {
      publication_id: $(this).val()
    }
  });
});