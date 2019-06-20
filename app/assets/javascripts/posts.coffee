# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'change', '#post_publication_id', ->
  $.ajax(
    type: 'GET'
    url: '/posts/get_image'
    data: {
      publication_id: $(this).val()
    }
  ).done (data) ->
    $('.book_image').html(data)

$(document).on 'click', '#fake_btn_back', ->
  document.getElementById('btn_back').click()
  return
