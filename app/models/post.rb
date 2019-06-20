class Post < ApplicationRecord
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :users, through: :goods
  has_many :tags, through: :posts
  has_one :user, through: :book
  has_one :publication, through: :book
  # delegate :publication, to: :book
  # delegate :user, to: :book

  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 200 }

  def good_user(user)
    goods.where(user_id: user.id)
  end

  scope :search_book_name, ->(book_name) do
    joins(:publication).where('publications.title like ?', "%#{book_name}%") if book_name.present?
  end

  scope :search_user_name, ->(user_name) do
    joins(:user).where('users.name like ?', "%#{user_name}%") if user_name.present?
  end

  scope :search_post, ->(book_name, user_name) do
    return false if book_name.nil? && user_name.nil?

    search_book_name(book_name).search_user_name(user_name)
  end
end
