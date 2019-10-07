class AddColumnPublication < ActiveRecord::Migration[5.2]
  def up
    add_column :publications, :price, :integer
  end

  def down
    remove_column :publications, :price, :integer
  end
end
