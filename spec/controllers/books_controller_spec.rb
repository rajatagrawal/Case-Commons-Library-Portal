require 'spec_helper'

describe BooksController do

  fixtures :all

  describe 'POST #create' do
    let(:book) do
      book = Book.new
      book.title = 'BookTitle'
      book.author = 'BookAuthor'
      book.publisher = 'BookPublisher'
      book.price = 123
      book
    end

    before do
      sign_in(users(:admin))
      post :create, book: book.attributes.except('user_id','updated_at','created_at')
    end

    it 'creates a new book' do
      expect(Book.find_by_title('BookTitle').id).to_not be_nil
    end

    it 'redirects to the user profile page' do
      expect(response).to redirect_to user_profile_path(users(:admin))
    end

    it 'shows a flash message of successful creation of the book' do
      expect(flash[:success]).to eq 'Added a new book successfully'
    end
  end

  describe 'PUT #update' do
    let(:book) do
      book = Book.first
      book.title = 'UpdateBookTitle'
      book.author = 'UpdateBookAuthor'
      book.publisher = 'UpdateBookPublisher'
      book.price = 123
      book
    end
    let(:book_id) { book.id }

    before do
      sign_in(users(:admin))
      put :update, book: book.attributes.except('user_id','updated_at','created_at'), id: book_id
    end

    it 'updates the book details' do
      expect(Book.find(book_id).title).to eq 'UpdateBookTitle'
      expect(Book.find(book_id).author).to eq 'UpdateBookAuthor'
      expect(Book.find(book_id).publisher).to eq 'UpdateBookPublisher'
      expect(Book.find(book_id).price).to eq 123
    end

    it 'redirects to the user profile page' do
      expect(response).to redirect_to user_profile_path(users(:admin))
    end

    it 'shows a flash message of successful creation of the book' do
      expect(flash[:success]).to eq 'Successfully updated the book'
    end

  end

  describe 'DELETE #destroy' do
    let(:book_id) { Book.first.id }
    before do
      sign_in(users(:admin))
      delete :destroy, id: book_id
    end
    it 'deletes the book' do
      expect{ Book.find(book_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'redirects to the current user profile page' do
      expect(response).to redirect_to user_profile_path(users(:admin))
    end

    it 'shows a flash message of successful deletion of the book' do
      expect(flash[:success]).to eq 'Successfully deleted the book'
    end
  end

  describe 'POST #checkout' do
    let(:book_to_checkout) { books(:book1) }
    let(:user) { users(:employee) }
    before do
      sign_in(user)
      post :checkout, id: book_to_checkout.id
    end

      it 'checks out the current book from the database' do
        expect(user.current_issued_books).to include book_to_checkout
        issued_user_books = user.user_books.select { |user_book| user_book.book_id == book_to_checkout.id }
        expect(issued_user_books.map(&:returned_on)).to include nil
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to user_profile_path(users(:employee))
      end

      it 'shows a flash message of successful book checkout' do
        expect(flash[:success]).to eq 'Successfully checked out the book'
      end
  end

  describe 'POST #checkin' do
    let(:book_to_checkin) { books(:book1)}
    let(:user) { users(:employee) }

    before do
      sign_in(user)
      UserBook.create(book_id: book_to_checkin.id, user_id: user.id, issued_on: Time.now)
      post :checkin, id: book_to_checkin.id
    end

    it 'checks in the book' do
      expect(user.current_issued_books).to_not include book_to_checkin
      expect(user.all_issued_books).to include book_to_checkin
    end

    it 'redirects the user profile page' do
      expect(response).to redirect_to user_profile_path(users(:employee))
    end

    it 'shows a successful checkin flash message' do
      expect(flash[:success]).to eq 'Successfully checked in the book'
    end
  end
end
