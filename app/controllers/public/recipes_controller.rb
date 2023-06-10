class Public::RecipesController < ApplicationController
  
  def new
     @recipe = Recipe.new  
  end
  
  def create
    recipe = current_user.recipes.new(recipe_params)
    recipe.user_id = current_user.id
    if recipe.save
      redirect_to recipes_path
      # , flash: { notice: "「#{recipe.title}」のレシピを投稿しました。" }
    else
      redirect_to new_recipe_path
      # , flash: {
      #   recipe: recipe,
      #   error_messages: recipe.errors.full_messages
      # }
    end
  end
   def index
    # @title = "レシピ一覧"
    @recipes = Recipe.all
    # params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes : Recipe
    if user_signed_in?
      @recipes = @recipes.includes([:user], [:favorites]).page(params[:page]).per(6)
    else
      @recipes = @recipes.includes([:user]).page(params[:page]).per(6)
    end
   end
   
   def show
     @recipe = Recipe.find(params.id)
      # @title = "#{@recipe.title}"
    @comments = Comment.includes([:user]).where(recipe_id: @recipe.id)

    if user_signed_in?
      @comment = current_user.comments.new(flash[:comment])
      @comment_reply = current_user.comments.new
    end
   end

  def destroy
       recipe = Recipe.find(params[:id])
    if recipe.destroy
    flash[:notice] = "削除が成功しました"  
    redirect_to recipes_path
    end
  end
  private
  def recipe_params
      params.require(:recipe).permit(:image,:title,:description,:star,:steps,:ingredients,
        # :remove_image,
        # :image_cache,
        # :keyword,
        tag_ids: [],
        ingredients_attributes: [:id, :content, :quantity, :_destroy],
        steps_attributes: [:id, :direction, :image, :_destroy]
      )
  end
end