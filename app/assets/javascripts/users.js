$(document).on('turbolinks:load', function() {
  var $fileField;
  $fileField = $('#file');
  $($fileField).on('change', $fileField, function(e) {
    var $preview, file, reader;
    file = e.target.files[0];
    reader = new FileReader;
    $preview = $('#img_field');
    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: '100%',
          "class": 'preview',
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});