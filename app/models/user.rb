class User < ApplicationRecord
  has_secure_password 
  before_create :confirmation_token
  has_one_attached :image_link
  has_many :post, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_many :conversations, :foreign_key => :sender_id
  has_many :messages
  has_many :friendships
  has_many :confirmed_friends, -> { where(friendships: { friendship_status: true }) }, through: :friendships, source: :friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_confirmed_friends, -> { where(friendships: { friendship_status: true }) }, through: :inverse_friendships, source: :user
  has_many :notifications, dependent: :destroy, as: :recipient
  validates :first_name,  presence: true  
  validates :last_name,  presence: true  
  validates :email, presence: true, uniqueness: true,  
            format: {  
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i  
            }
  validates :password, presence: true ,length: { minimum: 6 }          
  # validates :contact, numericality: { only_integer: true}
  def to_s  
    "#{first_name} #{last_name}"  
  end  
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }
 
 def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  
 private

  def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
  end
end
