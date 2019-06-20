class Post < ApplicationRecord
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :users, through: :goods
  delegate :publication, to: :book
  delegate :user, to: :book

  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 200 }

  def good_user(user)
    goods.where(user_id: user.id)
  end
end
