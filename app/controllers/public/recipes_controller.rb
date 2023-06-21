class Public::RecipesController < ApplicationController
  
  def new
     @recipe = Recipe.new  
     @tags = Tag.where(name: Tag::SELECT_TAG)
  end
  
  def create
    recipe = current_user.recipes.new(recipe_params)
    recipe.user_id = current_user.id
    tag_names = params[:recipe][:tag_names].split(',')
    if recipe.save!
        recipe.save_tags(tag_names)
      flash[:notice] = "レシピを投稿しました。"
      redirect_to recipes_path
    else
      @recipes = Recipe.all
      flash[:notice] = "error"
      render :index
    end
  end

   def index
    # @title = "レシピ一覧"
    @recipes = Recipe.all
    # params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes : Recipe
     @recipes = params[:tag_ids].present? ? Tag.find(params[:tag_ids]).recipes : Recipe.all
    if user_signed_in?
      @recipes = @recipes.includes([:user], [:favorites]).page(params[:page]).per(6)
    else
      @recipes = @recipes.includes([:user]).page(params[:page]).per(6)
    end
   end
   
   def show
    @recipe = Recipe.find(params[:id])
      # @title = "#{@recipe.title}"
    # @comments = Comment.includes([:user]).where(recipe_id: @recipe.id)
    
    @comments = @recipe.comments  #投稿詳細に関連付けてあるコメントを全取得
    
    # @comment = current_user.comments.new  
    #投稿詳細画面でコメントの投稿を行うので、
    #formのパラメータ用にCommentオブジェクトを取得
    
    # if user_signed_in?
    #   @comment = current_user.comments.new(flash[:comment])
    #   @comment_reply = current_user.comments.new
    # end
     # raty.js用のフォーム
    @review = Review.new
    # raty.jsの平均値
    @review_avg = Review.where(recipe_id: params[:id]).average(:review)
    # すでに評価済みかの確認フラグ
    @review_flg = Review.find_by(user_id: current_user.id, recipe_id: params[:id])
   end
   
   def update
        @recipe = Recipe.find(params[:id])
        tag_list = params[:recipe][:tag_ids].split(',')
     if @recipe.update(recipe_params)
         @recipe.save_tags(tag_list)
        flash[:notice] = "successfully"  
        redirect_to recipe_path(@recipe.id)  
     else 
        flash[:notice] = "error"  
        render :edit
     end
   end
     
    def edit
        @recipe = Recipe.find(params[:id])
        @tag_list =@recipe.tags.pluck(:name).join(",")
        if  @recipe.user == current_user
            render :edit
        else 
            redirect_to recipes_path
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
      params.require(:recipe).permit(:image,:title,:description,:review,:steps,:ingredients,
        # :remove_image,
        # :image_cache,
        # :keyword,
        tag_ids: [],
        tag_names: [],
        ingredients_attributes: [:id, :content, :quantity, :_destroy],
        steps_attributes: [:id, :direction, :image, :_destroy]
      )
  end
end