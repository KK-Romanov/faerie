class Public::CommentsController < ApplicationController
  def create
    # comment = Comment.new(comment_params)
    @comment = current_user.comments.new(comment_params)
    if @comment.save!
      if @comment.reply_comment.nil?
        flash[:notice] = 'レシピへのコメントを投稿しました。'
      else
        flash[:notice] = 'コメントに返信しました。'
      end
      redirect_to @comment.recipe
    else
      if @comment.reply_comment.nil?
        flash[:comment] = @comment
      end

      flash[:error_messages] = @comment.errors.full_messages
      redirect_back fallback_location: @comment.recipe
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], recipe_id: params[:recipe_id]).destroy
    redirect_to comment.recipe
    if comment.reply_comment.nil?
      flash[:notice] = 'コメントを削除しました。'
    else
      flash[:notice] = '返信したコメントを削除しました。'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :recipe_id, :reply_comment, :comments, :name, :content)
  end
end


# post_image = PostImage.find(params[:post_image_id])
#     comment = current_user.post_comments.new(post_comment_params)
#     comment.post_image_id = post_image.id
#     comment.save
#     redirect_to post_image_path(post_image)
#   end

#   private

#   def post_comment_params
#     params.require(:post_comment).permit(:comment)
#   end

