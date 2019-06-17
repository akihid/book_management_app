class Publication < ApplicationRecord
  validates :title, presence: true

  has_many :books, dependent: :destroy
  has_many :users, through: :books
end
