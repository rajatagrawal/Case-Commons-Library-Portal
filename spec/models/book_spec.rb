require 'spec_helper'

describe Book do

  it 'should validate the presence of its fields' do
    expect(subject).to validate_presence_of :title
    expect(subject).to validate_presence_of :author
    expect(subject).to validate_presence_of :publisher
    expect(subject).to validate_presence_of :price
  end

  it 'belongs to a user' do
    expect(subject).to have_many(:user_books)
  end

end

describe '#current_users' do
  fixtures :all

  let(:book) { Book.new }
  let(:user_book1) {
    UserBook.new(
      user_id: users(:employee).id,
      issued_on: 3.days.ago
    )}

  let(:user_book2) {
    UserBook.new(
      user_id: users(:employee2).id,
      issued_on: 3.days.ago,
      returned_on: 1.day.ago
    )}

  it 'returns the current users who have issued the book' do
    Book.any_instance.stub(:user_books).and_return([user_book1,user_book2])
    expect(book.current_users).to include users(:employee)
    expect(book.current_users).to_not include users(:employee2)
  end
end

describe '#all_users' do
  fixtures :all

  let(:book) { Book.new }
  let(:user_book1) {
    UserBook.new(
      user_id: users(:employee).id,
      issued_on: 3.days.ago
    )}

  let(:user_book2) {
    UserBook.new(
      user_id: users(:employee2).id,
      issued_on: 3.days.ago,
      returned_on: 1.day.ago
    )}

  it 'returns all the users who have issued the book up till now' do
    Book.any_instance.stub(:user_books).and_return([user_book1,user_book2])
    expect(book.all_users).to include users(:employee)
    expect(book.all_users).to include users(:employee2)
  end
end

describe '#checked_out?' do
  fixtures :books
  context 'if the book is issued and not returned' do
    let(:book) { books(:unreturned_issued_book) }
    it 'should return true' do
      expect(book.checked_out?).to eq true
    end

  end

  context 'if the book is issued and returned' do
    let(:book) { books(:returned_issued_book) }
    it 'should return false' do
      expect(book.checked_out?).to eq false
    end

  end

  context 'if the book is not issued' do
    let(:book) { books(:unissued_book) }
    it 'should return false' do
      expect(book.checked_out?).to eq false
    end
  end
end

describe '#can_be_checked_out?' do
  fixtures :books

  context 'when the quantity of books is 1 and the book is issued' do
    let(:book) { books(:unreturned_issued_book) }
    it 'returns false' do
      expect(book.can_be_checked_out?).to eq false
    end
  end

  context 'when the quantity of books more than 1 and less number of books are issued' do
    let(:book) { books(:unreturned_issued_book_with_multiple_copies) }
    it 'returns true' do
      expect(book.can_be_checked_out?).to eq true
    end
  end

  context 'when the book is not issued' do
    let(:book) { books(:unissued_book) }
    it 'returns true' do
      expect(book.can_be_checked_out?).to eq true
    end
  end
end

describe '#number_of_issued_copies' do
  fixtures :all
  context 'when the book is not issued' do
    let(:book) { books(:unissued_book) }
    it 'returns 0' do
      expect(book.number_of_issued_copies).to eq 0
    end
  end

  context 'when the book is issued' do
    let(:book1) { books(:unreturned_issued_book) }
    let(:book2) { books(:unreturned_issued_book_with_multiple_copies) }
    it 'returns the number of times the book is issued' do
      expect(book1.number_of_issued_copies).to eq 1
      expect(book2.number_of_issued_copies).to eq 3
    end
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
    allow(book).to receive(:user_books).and_return([user_book1,user_book2])
  end
  it 'returns the user book record for issued book passed in' do
    expect(book.user_book_records(user)).to include user_book1
    expect(book.user_book_records(user)).to_not include user_book2
  end
end

describe '#cannot_checkout_more_than_quantity' do
  let(:book) do
    book = Book.new
    book
  end

  context 'when the number of issued books is less than the quantity' do
    before do
      allow(book).to receive(:number_of_issued_copies).and_return(3)
      allow(book).to receive(:quantity).and_return(4)
    end

    it 'does not add error message' do
      book.valid?
      expect(book.errors[:base]).to_not include 'can not issue any more books.'
    end
  end

  context 'when the number of issued books is same as the quantity' do

    before do
      allow(book).to receive(:number_of_issued_copies).and_return(3)
      allow(book).to receive(:quantity).and_return(3)
    end

    it 'adds an error message' do
      book.valid?
      expect(book.errors[:base]).to include 'can not issue any more books.'
    end
  end
end
