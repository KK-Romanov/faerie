class RecipeTagRelation < ApplicationRecord
#   レシピ 
  belongs_to :recipe
#   タグ系
  belongs_to :tag

  validates :recipe_id, presence: true
  validates :tag_id, presence: true
end
