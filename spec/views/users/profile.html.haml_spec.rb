require 'spec_helper'

describe 'users/profile' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'page contents' do
    let(:user1) {
      user = User.new
      user.first_name = 'First Name'
      user.last_name = 'Last Name'
      user
    }

    before do
      assign(:user, user1)
    end

    context 'if the user does not have issued books' do
      it 'shows no books issued message' do
        allow(user1).to receive(:current_issued_books).and_return([])
        expect(page).to have_content('You have not issued any books yet. Want to check out a book?')
      end

      it 'shows a link to check out the book' do
        expect(page).to have_css('a',text: 'check out')
      end

      it 'does not show the second link to check out a book' do
        expect(page).to_not have_css('a',text: 'Check out a book')
      end
    end

    context 'if the user has issued books' do
      let(:book1) do
        book = Book.new
        book.id = 1
        book.title = 'Book1 title'
        book
      end

      let(:user_book1) {
        user_book = UserBook.new
        user_book.user_id = user1.id
        user_book.book_id = book1.id
        user_book.issued_on = 3.days.ago
        user_book
      }

      let(:book2) do
        book = Book.new
        book.id = 2
        book.title = 'Book2 title'
        book
      end

      before do
        allow(user1).to receive(:current_issued_books).and_return([book1,book2])
        allow(user1).to receive(:user_books).and_return([user_book1])
        allow(user1).to receive(:user_book_records).and_return([user_book1])
      end
      it 'has the table structure to show the books' do
        expect(page).to have_css('th', text: 'Serial No')
        expect(page).to have_css('th', text: 'Book')
        expect(page).to have_css('th', text: 'Issued On')
        expect(page).to have_css('th', text: 'Check In?')
      end
      it 'shows the label for issued books' do
        expect(page).to have_content('You have issued the following books')
      end
      it 'shows a named link of the issued books' do
        expect(page).to have_css('a',text: book1.title)
        expect(page).to have_css('a',text: book2.title)
      end

      it 'shows when the book was issued' do
        expect(page).to have_content(3.days.ago.in_time_zone("Eastern Time (US & Canada)").to_formatted_s(:long_ordinal))
      end

      it 'shows a button to check in the book' do
        expect(page).to have_css('a', 'Check In')
      end
    end

  end

  context 'when the logged in user is admin' do
    let(:user) { users(:admin) }

    before do
      assign(:user, user)
    end

    it 'shows the add a new book button' do
      expect(page).to have_css('a',text: 'Add a book')
    end

    it 'shows the delete a book button' do
      expect(page).to have_css('a','Delete a book')
    end

    it 'shows edit a book button' do
      expect(page).to have_css('a','Edit a book')
    end

    it 'shows add a user button' do
      expect(page).to have_css('a','Add a user')
    end

    it 'shows edit a user button' do
      expect(page).to have_css('a','Edit a user')
    end

    it 'shows delete a user button' do
      expect(page).to have_css('a','Delete a user')
    end
  end
end
