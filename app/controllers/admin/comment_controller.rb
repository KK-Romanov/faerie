class Admin::CommentController < ApplicationController
  
  def index
    # @comments = @recipe.comments
     @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
  end
private
    def comment_params
        params.require(:comment).permit(:recipe_id, :content, :comments, 
        :user_id, :reply_comment ) 
    end

end
