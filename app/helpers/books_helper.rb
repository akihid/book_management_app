module BooksHelper
  def chose_new_or_edit
    if action_name == 'new'
      user_books_path
    else
      user_book_path
    end
  end
end
