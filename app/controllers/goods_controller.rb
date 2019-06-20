class GoodsController < ApplicationController
  before_action :set_post

  def create
    @good = current_user.goods.create(post_id: params[:post_id])
    @goods = Good.where(post_id: params[:post_id])
    @post.reload
  end

  def destroy
    good = current_user.goods.find_by(id: params[:id])
    good.destroy
    @goods = Good.where(post_id: params[:post_id])
    @post.reload
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
