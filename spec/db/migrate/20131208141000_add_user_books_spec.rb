# require 'spec_helper'
# require Rails.root.join("db", "migrate", '20131208141000_add_user_books')

# describe AddUserBooks, data_migration: true do
  # describe '.up' do
    # before do
      # AddUserBooks.new.up
    # end
    # it' creates a user_books table' do
      # expect(ActiveRecord::Base.connection.table_exists? 'user_books').to be_true
    # end

    # it 'creates a column to store the user id' do
      # expect(ActiveRecord::Base.connection.column_exists?('user_books','user_id')).to be_true
    # end

    # it 'creates a column to store the book id' do
      # expect(ActiveRecord::Base.connection.column_exists? 'user_books','book_id').to be_true
    # end

    # it 'creates a column to store the issue date' do
      # expect(ActiveRecord::Base.connection.column_exists? 'user_books','issued_on',:datetime).to be_true
    # end

    # it 'creates a column to store the return date' do
      # expect(ActiveRecord::Base.connection.column_exists? 'user_books','returned_on',:datetime).to be_true
    # end

    # it 'adds index on the id column' do
      # expect(ActiveRecord::Base.connection.index_exists? 'user_books','id').to be_true
    # end
    # it 'creates timestamps columnns for the table' do
      # expect(ActiveRecord::Base.connection.column_exists? 'user_books','created_at').to be_true
      # expect(ActiveRecord::Base.connection.column_exists? 'user_books','updated_at').to be_true
    # end
  # end

  # describe '.down' do
    # it 'drops the user_books table' do
      # AddUserBooks.new.up
      # expect(ActiveRecord::Base.connection.table_exists? 'user_books').to be_true
      # AddUserBooks.new.down
      # expect(ActiveRecord::Base.connection.table_exists? 'user_books').to be_false
    # end
  # end
# end
