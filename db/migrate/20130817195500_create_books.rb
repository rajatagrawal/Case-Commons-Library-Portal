class CreateBooks < ActiveRecord::Migration

  def up
    create_table :books do |t|
      t.text :title
      t.text :author
      t.text :publisher
      t.decimal :price
      t.belongs_to :user

      t.timestamps
    end
  end

  def down
    drop_table :books
  end
end
