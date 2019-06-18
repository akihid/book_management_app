class Publication < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :users, through: :books

  validates :title, presence: true
end
