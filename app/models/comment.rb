class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  
  has_many :replies, class_name: :Comment, 
   foreign_key: :reply_comment, dependent: :destroy

end
