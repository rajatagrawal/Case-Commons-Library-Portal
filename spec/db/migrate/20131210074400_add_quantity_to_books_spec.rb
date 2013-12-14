# require 'spec_helper'
# require Rails.root.join("db", "migrate", '20131210074400_add_quantity_to_books')
# describe AddQuantityToBooks do
  # describe '.up' do
    # before do
      # described_class.up
    # end
    # it 'add a quantity column to the books table' do
      # expect(ActiveRecord::Base.connection.column_exists? 'books', 'quantity', :integer, { null: false }).to be_true
    # end
  # end

  # describe '.down' do
    # it 'removes quantity column from the books table' do
      # described_class.up
      # expect(ActiveRecord::Base.connection.column_exists? 'books', 'quantity', :integer, { null: false }).to be_true
      # described_class.down
      # expect(ActiveRecord::Base.connection.column_exists? 'books', 'quantity', :integer, { null: false }).to be_false
    # end
  # end
# end
