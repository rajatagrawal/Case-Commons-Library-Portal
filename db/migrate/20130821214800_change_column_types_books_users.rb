class ChangeColumnTypesBooksUsers < ActiveRecord::Migration
  def up
    change_column :books, :title, :string
    change_column :books, :author,  :string
    change_column :books, :publisher, :string

    change_column :users, :first_name, :string
    change_column :users, :last_name, :string
    change_column :users, :email, :string
  end

  def down
    change_column :books, :title, :text
    change_column :books, :author,  :text
    change_column :books, :publisher, :text

    change_column :users, :first_name, :text
    change_column :users, :last_name, :text
    change_column :users, :email, :text
  end
end
