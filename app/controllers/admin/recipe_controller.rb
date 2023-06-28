class Admin::RecipeController < ApplicationController
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
    
  end
   private
    def recipe_params
        params.require(:recipe).permit(:title, :description, :review, 
        :recipe_id, :user_id) 
    end
end
