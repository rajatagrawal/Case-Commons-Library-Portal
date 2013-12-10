class AddIssuedBooks < ActiveRecord::Migration
  def up
    create_table :issued_books do |t|
      t.belongs_to :user, null: false
      t.belongs_to :book, null: false
      t.column :issued_on, :datetime, null: false
      t.timestamps

    end
    add_index :issued_books, :id
  end

  def down
    drop_table :issued_books
  end
end
