class GoodsController < ApplicationController
  before_action :set_post

  def create
    @good = current_user.goods.new(post_id: params[:post_id])
    redirect_back_to_request('すでにいいね済なので登録できません') if @good.invalid?
    @good.save
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
