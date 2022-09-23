class Post < ApplicationRecord
 has_one_attached :image
 belongs_to :user
 default_scope -> { order(created_at: :desc) }
 has_many :comment, dependent: :destroy
 has_many :likes, dependent: :destroy
 has_rich_text :content
end
