class RemoveNonNullConstraint < ActiveRecord::Migration
  def self.up
    change_column :user_books, :returned_on, :datetime, null: true
  end

  def self.down
    change_column :user_books, :returned_on, :datetime, null: false
  end
end
