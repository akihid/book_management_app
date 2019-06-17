class UsersController < ApplicationController
  before_action :set_user , only:[:show]
  def show
    # binding.pry
    @books = current_user.books.search_book(params[:title] ,params[:author])
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def find_book

  end
end
