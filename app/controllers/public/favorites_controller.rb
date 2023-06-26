class Public::FavoritesController < ApplicationController
   before_action :authenticate_user!
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



# いいね機能＝＞ブックマーク機能に展開
#   def create
#     recipe = Recipe.find(params[:recipe_id])
#     favorite = recipe.favorites.new(user_id: current_user.id)
#     if favorite.save
#       redirect_to request.referer
#     else
#       redirect_to request.referer
#     end
#   end

#   def destroy
#     recipe = Recipe.find(params[:recipe_id])
#     favorite = recipe.favorites.find_by(user_id: current_user.id)
#     if favorite.present?
#        favorite.destroy
#         redirect_to request.referer
#     else
#         redirect_to request.referer
#     end
#   end
# end
# # fovorite.present?を挟んでいるのは、２度押しのエラーを回避するためです。

