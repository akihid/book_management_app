class PostsController < ApplicationController
  PER = 6
  before_action :set_post, only: %i[edit update show destroy]
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user, :publication).search_post(params[:book_name], params[:user_name]).order_new
    @posts = @posts.page(params[:page]).per(PER)
    search_result_is_present?(@posts)
  end

  def new
    check_user_have_book
    @post = if params[:back]
              Post.new(post_params)
            else
              Post.new
            end
  end

  def confirm
    book = current_user.books.find_by(publication_id: params[:post][:publication_id])
    @post = book.posts.build(post_params)
    render 'new' if @post.invalid?
  end

  def create
    book = current_user.books.find_by(publication_id: params[:post][:publication_id])
    @post = book.posts.build(post_params)

    if @post.save
      flash[:success] = '新規投稿しました。'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    return unless editable?
  end

  def update
    if @post.update(post_params)
      flash[:info] = '投稿の編集をしました。'
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def show
    @comments = @post.comments.includes(:user)
    @comment = @post.comments.includes(:user).build
    @good = current_user.goods.find_by(post_id: @post.id)
  end

  def destroy
    @post.destroy
    flash[:danger] = '投稿を削除しました。'
    redirect_to posts_path
  end

  def book_image
    image = Publication.find(params[:publication_id]).image
    respond_to do |format|
      format.js { render :book_image, locals: { image: image }}
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def check_user_have_book
    return if current_user.publications.exists?

    flash[:danger] = '本を持っていないと感想はかけません'
    redirect_to user_path(current_user.id)
  end

  def editable?
    return if @post.editable?(current_user.id)

    flash[:danger] = '編集する権限を持っていません'
    redirect_to posts_path
    false
  end
end
