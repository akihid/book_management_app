class BooksController < ApplicationController
  def index
    @books = current_user.books
  end

  def new
    @book = current_user.books.build(publication_id: params[:publication])
    redirect_back_to_request("#{params[:title]}はすでに持っているため登録できません") if @book.invalid?
  end

  def create
    @book = current_user.books.build(book_params)
    @book.save
    flash[:success] = "#{@book.publication.title}の登録完了"
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:user_id, :publication_id, :category_list)
  end

  def redirect_back_to_request(err_msg)
    redirect_back(fallback_location: request.url)
    flash[:danger] = err_msg
  end
end
