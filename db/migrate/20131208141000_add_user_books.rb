class AddUserBooks < ActiveRecord::Migration
  def up
    create_table :user_books do |t|
      t.belongs_to :user, null: false
      t.belongs_to :book, null: false
      t.column :issued_on, :datetime, null: false
      t.column :returned_on, :datetime, null: false
      t.timestamps

    end
    add_index :user_books, :id
  end

  def down
    drop_table :user_books
  end
end
