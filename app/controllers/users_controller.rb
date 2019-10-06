class UsersController < ApplicationController
  PER = 6
  before_action :set_user, only: [:show]
  def show
    @books = @user.books.includes(:publication, :taggings).search_book(params[:title], params[:author]).order_new        
    @books = @books.tagged_with(params[:category_name]) if params[:category_name].present?
    @books = @books.page(params[:page]).per(PER)  

    @posts = @user.book_posts
    @comment_posts = @user.comment_posts.includes(:publication, :user)
    @good_posts = @user.good_posts.includes(:publication, :user)

    sum_price
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def sum_price
    price_hash = @user.books.includes(:publication).group(:read_status).sum(:price)
    not_read_price = price_hash["not_read"].present? ? price_hash["not_read"] : 0 
    now_read_price = price_hash["now_read"].present? ? price_hash["now_read"] : 0 
    
    @not_read_price = not_read_price + now_read_price
    @finish_read_price = price_hash["finish_read"].present? ? price_hash["finish_read"] : 0 
  end
end
