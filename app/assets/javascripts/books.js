$(document).on('turbolinks:load', function() {
  return $('#book-tags').tagit({
    singleField: true
  });
});