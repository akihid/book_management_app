class Book < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  has_many :posts, dependent: :destroy
  acts_as_taggable_on :categories

  enum read_status: { not_read: 0, now_read: 1, finish_read: 2, }
  validates :read_status, inclusion:{ in: Book.read_statuses.keys}

  validates :user_id, presence: true, uniqueness: { scope: :publication_id }

  scope :search_title, ->(title) do
    joins(:publication).where('publications.title like ?', "%#{title}%") if title.present?
  end

  scope :search_author, ->(author) do
    joins(:publication).where('publications.author like ?', "%#{author}%") if author.present?
  end

  scope :search_read_status, ->(read_status) do
    where('read_status = ?', read_status) if read_status.present?
  end

  scope :order_new, ->() do
    order('books.updated_at DESC')
  end

  scope :search_book, ->(title, author, read_status) do
    return false if title.nil? && author.nil?

    search_title(title).search_author(author).search_read_status(read_status).order_new
  end

  def editable?(user_id)
    user_id == user.id
  end
end
