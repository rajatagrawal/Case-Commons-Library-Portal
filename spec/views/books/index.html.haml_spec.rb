require 'spec_helper'

describe 'books/index' do
  let(:page) {Capybara.string(render)}

  fixtures :all
  context 'page layout' do
    before do
      allow(view).to receive(:current_user).and_return(users(:employee))
      assign(:books,[])
    end
    it 'shows the title of the page' do
      expect(page).to have_css('h2','List of all the books')
    end
    it 'shows the table header for book title' do
      expect(page).to have_css('th', text: 'Title')
    end

    it 'shows the table header for book author' do
      expect(page).to have_css('th', text: 'Author')
    end

    it 'shows the table header for book publisher' do
      expect(page).to have_css('th', text: 'Publisher')
    end

    it 'shows the table header for book quantity' do
      expect(page).to have_css('th', text: 'Quantity')
    end

    it 'shows the table header for status of the book' do
      expect(page).to have_css('th', text: 'Status')
    end
  end

  context 'book information' do
    let(:book1) do
      book = Book.new
      book.id = 1
      book.title = 'Book1 Title'
      book.author = 'Book1 Author'
      book.publisher = 'Book1 Publisher'
      book.quantity = 3
      book
    end

    let(:book2) do
      book = Book.new
      book.id = 2
      book.title = 'Book2 Title'
      book.author = 'Book2 Author'
      book.publisher = 'Book2 Publisher'
      book.quantity = 1
      book
    end

    before do
      allow(view).to receive(:current_user).and_return(users(:employee))
      assign(:books, [book1,book2])
    end
    it 'shows the titles of the books' do
      expect(page).to have_css('a', text: 'Book1 Title')
      expect(page).to have_css('a', text: 'Book2 Title')
    end

    it 'shows the authors of the books' do
      expect(page).to have_css('td', text: 'Book1 Author')
      expect(page).to have_css('td', text: 'Book2 Author')
    end

    it 'shows the publishers of the books' do
      expect(page).to have_css('td', text: 'Book1 Publisher')
      expect(page).to have_css('td', text: 'Book2 Publisher')
    end

    it 'shows the quantities of the books' do
      expect(page).to have_css('td', text: '3')
      expect(page).to have_css('td', text: '1')
    end

    context 'when the books are checked out' do
      before do
        Book.any_instance.stub(:checked_out?).and_return(true)
      end
      let(:user1) do
        user = User.new(
          first_name: 'BookUser1 First Name',
          last_name: 'BookUser1 Last Name'
        )
        user
      end
      let(:user2) do
        user = User.new(
          first_name: 'BookUser2 First Name',
          last_name: 'BookUser2 Last Name'
        )
        user
      end

      let(:user3) do
        user = User.new(
          first_name: 'BookUser3 First Name',
          last_name: 'BookUser3 Last Name'
        )
        user
      end

      it 'shows the checked out label' do
        expect(page).to have_content('Checked out by')
      end

      it 'shows the list of current users for each book' do
        allow(book1).to receive(:current_users).and_return([user1,user2])
        allow(book2).to receive(:current_users).and_return([user3])
        expect(page).to have_css('li',text: 'BookUser1 First Name BookUser1 Last Name')
        expect(page).to have_css('li',text: 'BookUser2 First Name BookUser2 Last Name')
        expect(page).to have_css('li',text: 'BookUser3 First Name BookUser3 Last Name')
      end
    end

    context 'when the books are not checked out' do
      before do
        Book.any_instance.stub(:checked_out?).and_return(false)
      end

      it 'does not show the checked out label' do
        expect(page).to_not have_content('Checked out by')
      end
    end

    context 'when the book can be checked out' do
      it 'shows a button to checkout the book' do
        Book.any_instance.stub(:can_be_checked_out?).and_return(true)
        expect(page).to have_button('Checkout')
      end
    end

    context 'when the book can not be checked out' do
      it 'shows a button to checkout the book' do
        Book.any_instance.stub(:can_be_checked_out?).and_return(false)
        expect(page).to have_content('No more copies left to checkout')
      end
    end
  end

  context 'when an admin user is logged in' do
    before do
      allow(view).to receive(:current_user).and_return(users(:admin))
      book1 = books(:unreturned_issued_book)
      book2 = books(:unreturned_issued_book_with_multiple_copies)
      assign(:books, [book1,book2])
    end

    context 'admin controls' do
      it 'shows a delete button' do
        expect(page).to have_button('Delete Book')
      end


      it 'shows an edit button' do
        expect(page).to have_button('Edit Book')
      end
    end
  end
end
