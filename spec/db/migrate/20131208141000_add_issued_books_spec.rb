# require 'spec_helper'
# require Rails.root.join("db", "migrate", '20131208141000_add_issued_books')

# describe AddIssuedBooks, data_migration: true do
  # describe '.up' do
    # before do
      # AddIssuedBooks.new.up
    # end
    # it' creates an issued_books table' do
      # expect(ActiveRecord::Base.connection.table_exists? 'issued_books').to be_true
    # end

    # it 'creates a column to store the user id' do
      # expect(ActiveRecord::Base.connection.column_exists?('issued_books','user_id')).to be_true
    # end

    # it 'creates a column to store the book id' do
      # expect(ActiveRecord::Base.connection.column_exists? 'issued_books','book_id').to be_true
    # end

    # it 'creates a column to store the issue date' do
      # expect(ActiveRecord::Base.connection.column_exists? 'issued_books','issued_on',:datetime).to be_true
    # end

    # it 'adds index on the id column' do
      # expect(ActiveRecord::Base.connection.index_exists? 'issued_books','id').to be_true
    # end
    # it 'creates timestamps columnns for the table' do
      # expect(ActiveRecord::Base.connection.column_exists? 'issued_books','created_at').to be_true
      # expect(ActiveRecord::Base.connection.column_exists? 'issued_books','updated_at').to be_true
    # end
  # end

  # describe '.down' do
    # it 'drops the issued_books table' do
      # AddIssuedBooks.new.up
      # expect(ActiveRecord::Base.connection.table_exists? 'issued_books').to be_true
      # AddIssuedBooks.new.down
      # expect(ActiveRecord::Base.connection.table_exists? 'issued_books').to be_false
    # end
  # end
# end
