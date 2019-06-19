class GoodsController < ApplicationController
  def create
    good = current_user.goods.create(post_id: params[:post_id])
    redirect_to posts_url, notice: "#{good.post.user.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    good = current_user.goods.find_by(id: params[:id]).destroy
    redirect_to posts_url, notice: "#{good.post.user.name}さんの投稿をお気に入り解除しました"
  end
end
