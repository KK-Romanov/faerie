class Recipe < ApplicationRecord
  belongs_to :user
#   材料関連
  default_scope -> { self.order(created_at: :desc) }

  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
#   作り方  
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
#   コメント
  has_many :comments, dependent: :destroy
#   タグ系
  has_many :recipe_tag_relations, dependent: :destroy, validate: false
  # accepts_nested_attributes_for :recipe_tag_relations, allow_destroy: true
  # （子）関連テーブルを合わせて、同時に複数保存。
  # allow_destroy は　編集・削除も可能とするoption
  
  has_many :tags, through: :recipe_tag_relations
#   いいね
  has_many :favorites, dependent: :destroy
#   レビュー
  has_many :reviews, dependent: :destroy
  has_one_attached :image
  
  validates :title, presence: true
  validates :description, presence: true
  # validates :image, presence: true
  
   def favorited_by?(user)
    favorites.exists?(user_id: user.id)
   end
   
  # def favorited_by?(user)
  #   favorites.where(user_id: user).exists?
  # end
  
  
   def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image1.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image1.jpg', content_type: 'image/jpeg')
    end
    image
   end

  def require_any_ingredients
    errors.add(:base, "材料は1つ以上登録してください。") if self.ingredients.blank?
  end

  def require_any_steps
    errors.add(:base, "作り方は1つ以上登録してください。") if self.steps.blank?
  end


def save_tags(saverecipe_tags) #= [b,c]
    current_tags = self.tags.pluck(:name) unless self.tags.nil? #=[a,b]
    old_tags = current_tags - 
    # [a,b]-[b,c] = a
    new_tags = saverecipe_tags - current_tags
    # [b,c]-[a,b] = c
    old_tags.each do |old_name| 
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name| 
      recipe_tag = Tag.find_or_create_by(name: new_name)
      # find or create なければ新規作成。
      # 
      self.tags << recipe_tag  # << = save 
    end
end
# self 呼び出し元探す　  これを指している＝＞recipe.save_tags(tag_names + checked_tag_names)
# = self = recipe
# -----------------
# def self.method
# end  /(ruby self) javaにもある。
end