class Post < ApplicationRecord
  belongs_to :book
  delegate :publication, to: :book
  delegate :user, to: :book

  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 200 }
end
