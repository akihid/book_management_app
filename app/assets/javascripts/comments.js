
$(document).on("turbolinks:load", function() {
  var obj = document.getElementById('comments_area');
  if ( obj ) {
    obj.scrollTop = obj.scrollHeight;
  }
});