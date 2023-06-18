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
  has_many :recipe_tag_relations, dependent: :delete_all, validate: false
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
   
  # def get_image
  #   if image.attached?
  #     image
  #   else
  #     'no-image1.jpg'
  #   end
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

end