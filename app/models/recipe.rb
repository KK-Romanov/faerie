class Recipe < ApplicationRecord
  belongs_to :user
#   材料関連
  has_many :ingredients, dependent: :destroy
#   作り方  
  has_many :steps, dependent: :destroy
#   コメント
  has_many :comments, dependent: :destroy
#   タグ系
  has_many :tags, through: :recipe_tag_relations
  has_many :recipe_tag_relations, dependent: :delete_all, validate: false
#   いいね
  has_many :favorites, dependent: :destroy
end
