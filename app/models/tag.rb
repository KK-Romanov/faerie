class Tag < ApplicationRecord
#  レシピ
  has_many :recipes, through: :recipe_tag_relations
#  レシピタグ  
  has_many :recipe_tag_relations, dependent: :delete_all

  validates :name, presence: true, uniqueness: { case_sensitive:  true }

end
