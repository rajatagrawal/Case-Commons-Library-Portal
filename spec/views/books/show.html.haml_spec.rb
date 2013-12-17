require 'spec_helper'

describe 'books/show' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'page contents' do
    before do
      assign(:book, book)
      allow(view).to receive(:current_user).and_return(users(:employee))
    end
    let(:book) do
      book = Book.new
      book.title = 'How to learn ruby'
      book.author = 'Rubyist'
      book.publisher = 'CaseCommonsPublishing'
      book.price = 123
      book
    end

    context 'page layout' do
      it 'shows the label to show the title of the book' do
        expect(page).to have_css('h1',text: 'How to learn ruby')
      end
      it 'shows the label to show the author of the book' do
        expect(page).to have_content('Author')
      end

      it 'shows the label to show the publisher of the book' do
        expect(page).to have_content('Publisher')
      end

      it 'shows the label to show the price of the book' do
        expect(page).to have_content('Price')
      end
    end

    it 'shows the name of the author' do
      expect(page).to have_content ': Rubyist'
    end

    it 'shows the name of the publisher' do
      expect(page).to have_content ': CaseCommonsPublishing'
    end

    it 'shows the price of the book' do
      expect(page).to have_content ': 123'
    end
    it 'shows a link to go the book index page' do
      expect(page).to have_css('a','See all books')
    end

    context 'when the book is checked out' do
      let(:user1) do
        user = User.new
        user.first_name = 'Bart'
        user.last_name = 'Simpson'
        user
      end
      let(:user2) do
        user = User.new
        user.first_name = 'Rajat'
        user.last_name = 'Agrawal'
        user
      end
      before do
        allow(book).to receive(:current_users).and_return([user1,user2])
      end

      it 'shows who the book is issued to ' do
        expect(page).to have_content('Issued by : ')
        book.current_users.each do |book_user|
          expect(page).to have_css('li',text: book_user.first_name + ' ' + book_user.last_name)
        end
      end

    end

    context 'when the book is not checked out' do
      before do
        allow(book).to receive(:current_users).and_return([])
      end

      it 'shows no body has issued the book' do
        expect(page).to have_content('Issued by')
        expect(page).to have_content('None')
      end

    end
  end
end
