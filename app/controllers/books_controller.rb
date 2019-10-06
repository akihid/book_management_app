class BooksController < ApplicationController
  before_action :set_book, only: %i[edit update destroy]
  before_action :authenticate_user!

  def new
    @book = current_user.books.build(publication_id: params[:publication])
    redirect_back_to_request("#{params[:title]}はすでに持っているため登録できません") if @book.invalid?
  end

  def create
    @book = current_user.books.build(book_params)
    @book.save
    flash[:success] = "#{@book.publication.title}の登録完了"
    redirect_to user_path(current_user.id)
  end

  def edit
    return unless editable?
  end

  def update
    if @book.update(book_params)
      flash[:success] = "#{@book.publication.title}の編集完了"
      redirect_to user_path(current_user.id)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    flash[:danger] = "#{@book.publication.title}の削除完了"
    redirect_to user_path(current_user.id)
  end

  private

  def book_params
    params.require(:book).permit(:user_id, :publication_id, :category_list, :read_status)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def editable?
    return if @book.editable?(current_user.id)

    flash[:danger] = '編集する権限を持っていません'
    redirect_to user_path(current_user.id)
    false
  end
end
