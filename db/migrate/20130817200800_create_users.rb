class CreateUsers < ActiveRecord::Migration

  def up
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.text :email_address

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
