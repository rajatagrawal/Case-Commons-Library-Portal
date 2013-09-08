class ChangeEmailUser < ActiveRecord::Migration
  def up
    rename_column :users, :email_address, :email
  end

  def down
    rename_column :users, :email, :email_address
  end
end
