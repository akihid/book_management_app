class Good < ApplicationRecord
  belongs_to :post, counter_cache: :goods_count
  belongs_to :user
end
