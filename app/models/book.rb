class Book < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: :publication_id }
  acts_as_taggable_on :categories

  belongs_to :user
  belongs_to :publication

  scope :search_title, ->(title) do
    joins(:publication).where('publications.title like ?', "%#{title}%") if title.present?
  end

  scope :search_author, ->(author) do
    joins(:publication).where('publications.author like ?', "%#{author}%") if author.present?
  end

  scope :search_book, ->(title, author) do
    return false if title.nil? && author.nil?

    search_title(title).search_author(author)
  end
end
