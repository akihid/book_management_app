class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def show
    @books = current_user.books.search_book(params[:title], params[:author])
    @books = @books.tagged_with(params[:category_name]) if params[:category_name]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
