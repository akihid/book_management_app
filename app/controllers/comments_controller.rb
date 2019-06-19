class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]

  def create
    set_comment_for_create
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to post_path(@post), notice: '投稿できませんでした...' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js { render :index }
      else
        format.html { redirect_to post_path(@post), notice: '削除できませんでした...' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comment_for_create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
  end
end
