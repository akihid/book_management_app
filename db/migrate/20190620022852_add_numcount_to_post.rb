class AddNumcountToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :goods_count, :integer, default: 0
  end
end
