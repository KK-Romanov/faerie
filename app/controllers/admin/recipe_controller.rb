class Admin::RecipeController < ApplicationController
    before_action :authenticate_admin!

  
  def index
     @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def destroy
       @recipe = Recipe.find(params[:id]).destroy
        redirect_to admin_recipe_index_path
  end
   private
    def recipe_params
        params.require(:recipe).permit(:title, :description, :review, 
        :recipe_id, :user_id) 
        
    end
    
    def if_not_admin
      redirect_to root_path unless current_user.admin?
  　end

  　def set_recipe
      @recipe = Recipe.find(params[:id])
  　end
    end       
end
