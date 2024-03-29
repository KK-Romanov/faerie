class Public::RecipesController < ApplicationController
   before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update]
   before_action :set_recipe, only: [:show, :edit, :update, :destroy]
   before_action :set_q, only: [:index, :search]
  
  def new
     @recipe = Recipe.new  
     @tags = Tag.where(name: Tag::SELECT_TAG)
  end
  
  def create
    @recipe = current_user.recipes.new(recipe_params)
    @recipe.user_id = current_user.id
    tag_names = params[:recipe][:tag_names].split(',')
    checked_tag_names = Tag.where(id: params[:recipe][:tag_ids]).pluck(:name)
    if @recipe.save
        @recipe.save_tags(tag_names + checked_tag_names)
      flash[:notice] = "レシピを投稿しました。"
      redirect_to recipes_path
    else
    #   @recipes = Recipe.all
      @tags = Tag.where(name: Tag::SELECT_TAG)
      flash[:notice] = "error"
      render :new
    end
  end

   def index
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true)
    # @title = "レシピ一覧"
    #@recipes = Recipe.all
    # params[:tag_id].present? ? Tag.find(params[:tag_id]).recipes : Recipe
    #@recipes = params[:tag_ids].present? ? Tag.find(params[:tag_ids]).recipes : Recipe.all
    
    # ransack 同時）タグ検索　調べる。
    @recipes = Tag.find(params[:tag_ids]).recipes if params[:tag_ids].present?
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
    #  @comment = current_user.comments.new(flash[:comment])
    #   @comment_reply = current_user.comments.new
    #  end
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
        flash[:success] = "レシピを更新しました。"
        redirect_to recipe_path(@recipe.id)  
     else 
        flash.now[:alert] = "更新が失敗しました"  
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
   
   def search
    if user_signed_in?
      @recipes = @q.result(distinct: true).includes([:favorites]).page(params[:page]).per(6)
    else
      @recipes = @q.result(distinct: true).includes([:user]).page(params[:page]).per(6)
    end
      @search = params[:q][:title_or_ingredients_content_cont]
   end
  
   def tag_search
      @tag = Tag.find(params[:tag_id])
      @recipes = @tag.recipes.includes([:user], [:favorites])
   end
   
  private
  
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def set_q
      @q = Recipe.ransack(params[:q])
    end
  
  def recipe_params
      params.require(:recipe).permit(:image,:title,:description,:review,:steps,:ingredients,
        # :remove_image,
        # :image_cache,
        :keyword,
        # tag_ids: [],
        # tag_names: [],
        ingredients_attributes: [:id, :content, :quantity, :_destroy],
        steps_attributes: [:id, :direction, :image, :_destroy]
      )
  end
end