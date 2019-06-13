class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.string :title
      t.string :author
      t.string :image
      t.string :isbn_code

      t.timestamps
    end
  end
end
