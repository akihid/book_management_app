class Good < ApplicationRecord
  belongs_to :post, counter_cache: :goods_count
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :post_id }
end
