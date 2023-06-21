class Tag < ApplicationRecord
#  レシピ
  has_many :recipes, through: :recipe_tag_relations
#  レシピタグ  
  has_many :recipe_tag_relations, dependent: :delete_all

  validates :name, presence: true, uniqueness: { case_sensitive:  true }
  
  SELECT_TAG = [
    "栄養満点",
    "簡単",
    "時短",
    "コスパ◎",
    "洋風",
    "中華風",
    "和風",
    "おもてなし"
  ]

end
