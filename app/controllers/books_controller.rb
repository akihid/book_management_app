class BooksController < ApplicationController
  def index
    @books = current_user.books
  end

  def new
    @book = current_user.books.build(publication_id: params[:publication])
  end

  def create
    @book =  current_user.books.build(book_params)
    if @book.save
      flash[:success] = '本の登録完了'
      redirect_to books_path
    else
      flash[:danger] = '登録済です'
      redirect_to publications_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:user_id, :publication_id, :category_list)
  end
end
