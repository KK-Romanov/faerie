class Ingredient < ApplicationRecord
    belongs_to :recipe

    # 材料・分量指定のバリデーション
  validates :content, presence: true
  validates :quantity, presence: true
end
