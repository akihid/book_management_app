class BooksController < ApplicationController
  def index
    @books = current_user.books
  end

  def new
    @book = current_user.books.build(publication_id: params[:publication])
  end

  def create
    @book = Book.find_or_initialize_by(user_id: current_user.id, publication_id: book_params[:publication_id])
    if @book.persisted?
      flash[:success] = '登録済です'
      redirect_to publications_path
    else
      @book.save
      flash[:success] = '本の登録完了'
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:publication_id)
  end
end
