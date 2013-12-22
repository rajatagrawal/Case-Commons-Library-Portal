require 'spec_helper'

describe UserBook do
  it 'belongs to a user' do
    expect(subject).to belong_to :user
  end

  it 'belongs to a book' do
    expect(subject).to belong_to :book
  end

  it 'should validate presense of the user' do
    expect(subject).to validate_presence_of :user
  end

  it 'should validate presense of the user' do
    expect(subject).to validate_presence_of :book
  end

  it 'should validate presense of the user' do
    expect(subject).to validate_presence_of :issued_on
  end
end

describe 'validates the associated book' do
  fixtures :all
  context 'when the number of checked out books quantity is equal to the book quantity' do
    let(:book) do
      book = books(:unreturned_issued_book)
    end

    context 'when creating a new user book record' do
      let(:user_book) do
        user_book = UserBook.new
        user_book.book_id = book.id
        user_book.user_id = book.user_books.first.user_id
        user_book.issued_on = Time.now
        user_book
      end
      it 'returns a validation error on checking out more number of books' do
        expect{ user_book.save! }.to raise_error
        expect(user_book.book.errors.full_messages).to include 'can not issue any more books.'
      end
    end

    context 'when updating an existing user book record' do
      let(:user_book) do
        user_book = UserBook.find(book.user_books.first)
        user_book.returned_on = Time.now
        user_book
      end
      it 'does not return a validation error' do
        expect{ user_book.save! }.to_not raise_error
        expect(user_book.book.errors.full_messages).to_not include 'can not issue any more books.'
      end
    end
  end

  context 'when the number of checked out books quantity is less than the book quantity' do
    let(:book) do
      book = books(:unreturned_issued_book_with_multiple_copies)
    end

    context 'when creating a new user book record' do
      let(:user_book) do
        user_book = UserBook.new
        user_book.book_id = book.id
        user_book.user_id = book.user_books.first.user_id
        user_book.issued_on = Time.now
        user_book
      end
      it 'does not throw a validation error on checking out more number of books' do
        expect{ user_book.save! }.to_not raise_error
        expect(user_book.book.errors.full_messages).to_not include 'can not issue any more books.'
      end
    end

    context 'when updating an existing user book record' do
      let(:user_book) do
        user_book = UserBook.find(book.user_books.first)
        user_book.returned_on = Time.now
        user_book
      end
      it 'does not return a validation error' do
        expect{ user_book.save! }.to_not raise_error
        expect(user_book.book.errors.full_messages).to_not include 'can not issue any more books.'
      end
    end
  end
end
