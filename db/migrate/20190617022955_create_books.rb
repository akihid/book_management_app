class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.integer :publication_id

      t.timestamps
    end
    add_index  :books, [:user_id, :publication_id], unique: true

  end
end
