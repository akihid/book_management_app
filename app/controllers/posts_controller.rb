class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update show]

  def index
    @posts = Post.all
  end

  def new
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
    # make check authority
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
    # make check authority
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
