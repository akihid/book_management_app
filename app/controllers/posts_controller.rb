class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
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

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
