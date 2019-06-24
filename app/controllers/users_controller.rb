class UsersController < ApplicationController
  PER = 6
  before_action :set_user, only: [:show]
  def show
    @books = @user.books.includes(:publication, :taggings).search_book(params[:title], params[:author]).order_new
    @books = @books.tagged_with(params[:category_name]) if params[:category_name].present?
    @books = @books.page(params[:page]).per(PER)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
