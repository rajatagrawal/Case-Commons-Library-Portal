class AddQuantityToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :quantity, :integer, null: false, default: 1
  end

  def self.down
    remove_column :books, :quantity
  end
end
