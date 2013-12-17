require 'spec_helper'

describe User do

  it 'should validate presence of its fields' do
    expect(subject).to validate_presence_of :first_name
    expect(subject).to validate_presence_of :last_name
    expect(subject).to validate_presence_of :email
    expect(subject).to validate_presence_of :role
  end

  it 'has many user_books' do
    expect(subject).to have_many(:user_books).dependent(:destroy)
  end

end

describe '#current_issued_books' do
  fixtures :all

  let(:user) { users(:employee) }
  let(:user_book1) {
    UserBook.new(
      user_id: user.id,
      book_id: books(:book1).id,
      issued_on: 3.days.ago,
    )
  }

  let(:user_book2) {
    UserBook.new(
      user_id: user.id,
      book_id: books(:book2).id,
      issued_on: 3.days.ago,
      returned_on: 1.day.ago,
    )
  }

  it 'returns the currently issued books' do
    allow(user).to receive(:user_books).and_return([user_book1,user_book2])
    expect(user.current_issued_books).to include books(:book1)
    expect(user.current_issued_books).to_not include books(:book2)
  end

end

describe '#all_issued_books' do
  fixtures :all

  let(:user) { users(:employee) }
  let(:user_book1) {
    UserBook.new(
      user_id: user.id,
      book_id: books(:book1).id,
      issued_on: 3.days.ago,
    )
  }

  let(:user_book2) {
    UserBook.new(
      user_id: user.id,
      book_id: books(:book2).id,
      issued_on: 3.days.ago,
      returned_on: 1.day.ago,
    )
  }

  it 'returns all the issued books by the user till now' do
    allow(user).to receive(:user_books).and_return([user_book1,user_book2])
    expect(user.all_issued_books).to include books(:book1)
    expect(user.all_issued_books).to include books(:book2)
  end

end

describe '#admin?' do

  let(:user) {User.new}

  context 'when the user is admin' do
    it 'returns true' do
      user.role = 'admin'
      expect(user.admin?).to eq true
    end
  end

  context 'when the user is not admin' do
    it 'returns false' do
      user.role = 'employee'
      expect(user.admin?).to eq false
    end
  end
end

describe '#full_name' do
  let(:full_name_user) do
    user = User.new
    user.first_name = 'First Name'
    user.last_name = 'Last Name'
    user
  end
  it 'returns the full name of the user' do
    expect(full_name_user.full_name).to eq 'First Name Last Name'
  end
end

describe 'user_book_records' do
  let(:book) do
    book = Book.new
    book.id = 1
    book
  end

  let(:user) do
    user = User.new
    user.id = 1
    user
  end

  let(:user_book1) do
    user_book = UserBook.new
    user_book.book_id = book.id
    user_book.user_id = user.id
    user_book
  end

  let(:user_book2) do
    user_book = UserBook.new
    user_book.book_id = book.id
    user_book.user_id = user.id
    user_book.returned_on = 1.day.ago
    user_book
  end

  before do
    allow(user).to receive(:user_books).and_return([user_book1,user_book2])
  end
  it 'returns the user book record for issued book passed in' do
    expect(user.user_book_records(book)).to include user_book1
    expect(user.user_book_records(book)).to_not include user_book2
  end
end
