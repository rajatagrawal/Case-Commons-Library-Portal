require 'spec_helper'

describe BooksController do

  fixtures :all

  describe 'POST #checkout' do
    let(:book_to_checkout) { books(:book1) }
    before do
      sign_in(users(:employee))
      post :checkout, id: book_to_checkout.id
    end

    describe 'if the book is not yet checked out' do
      it 'checks out the current book from the database' do
        expect(book_to_checkout.reload.checked_out?).to eq true
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to user_profile_path(users(:employee))
      end
    end

    describe 'if the book is already checked out' do
      let(:book_to_checkout) do
        book = books(:book1)
        book.user = users(:employee)
        book.save!
        book
      end

      it 'redirects to an error page' do
        expect(response.body).to eq "You can not check out this book because this book has already been issued by '#{book_to_checkout.user.first_name + ' ' + book_to_checkout.user.last_name}."
      end
    end
  end
end
