class Ingredient < ApplicationRecord
    belongs_to :recipe

    # 材料・分量指定のバリデーション
  validates :content, presence: true
  validates :quantity, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["description", "id",  "title",  "user_id", "ingredients", "content"]
  end
end
