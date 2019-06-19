$(document).on 'turbolinks:load', ->
  $fileField = $('#file')
  # 選択された画像を取得し表示
  $($fileField).on 'change', $fileField, (e) ->
    file = e.target.files[0]
    reader = new FileReader
    $preview = $('#img_field')
    reader.onload = do (file) ->
      (e) ->
        $preview.empty()
        $preview.append $('<img>').attr(
          src: e.target.result
          width: '100%'
          class: 'preview'
          title: file.name)
        return
    reader.readAsDataURL file
    return
  return