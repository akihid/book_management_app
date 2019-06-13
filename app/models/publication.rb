class Publication < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
end
