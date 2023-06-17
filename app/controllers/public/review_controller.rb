class Public::ReviewController < ApplicationController
   before_action :authenticate_user!

  def create
    @review = Review.new(review_params)
    if @review.save!
      redirect_to recipe_path(params[:recipe_id])
    else
      render :edit
    end
  end

  def destroy
    review = Review.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    # 自分自身の評価のみ削除を許可
    redirect_to recipe_path and return unless review.user_id == current_user.id
    review.destroy() # 評価削除
    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def review_params
    # mergeメソッドでユーザーID, 投稿_IDをStrongParameterに追加
    params.require(:review).permit(:review)
          .merge(
            user_id: current_user.id,
            recipe_id: params[:recipe_id]
          )
  end
end
