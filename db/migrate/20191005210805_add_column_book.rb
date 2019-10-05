class AddColumnBook < ActiveRecord::Migration[5.2]
  def up
    add_column :books, :read_status, :integer, default: 0
  end

  def down
    remove_column :books, :read_status, :integer
  end
end
