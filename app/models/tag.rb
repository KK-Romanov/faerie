class Tag < ApplicationRecord
#  レシピタグ  
  has_many :recipe_tag_relations, dependent: :destroy
#  レシピ
  has_many :recipes, through: :recipe_tag_relations
  # through option 中間テーブル通してで他テーブルと繋げる。
  
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
