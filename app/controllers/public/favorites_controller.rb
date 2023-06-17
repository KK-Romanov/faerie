class Public::FavoritesController < ApplicationController
   before_action :recipe_params
   
  def create
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.new(recipe_id: recipe.id)
    favorite.save
    redirect_to recipe_path(recipe)
  end


  def destroy
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.find_by(recipe_id: recipe.id)
    favorite.destroy
    redirect_to recipe_path(recipe)
  end


  private
    def recipe_params
      @recipe = Recipe.find(params[:recipe_id])
    end
end

