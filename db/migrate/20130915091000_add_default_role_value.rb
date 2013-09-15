class AddDefaultRoleValue < ActiveRecord::Migration
  def up
    change_column :users, :role, :string, default: :employee
  end

  def down
    change_column_default :users, :role, nil
  end
end
