class Post < ApplicationRecord
  belongs_to :book
  # has_many :publications, through: :books

  validates :title , presence: true , length: {maximum:20}
  validates :content , presence: true , length: {maximum:200}
end
