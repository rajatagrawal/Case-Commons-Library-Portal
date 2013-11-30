require 'spec_helper'

describe 'books/show' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'when the logged in user is admin' do
    before do
      assign(:book, books(:book1))
      allow(view).to receive(:current_user).and_return(users(:admin))
    end

    it 'shows a delete button' do
      expect(page).to have_button('Delete Book')
    end
  end

  context 'when the book is checked out' do
    let(:book) { books(:issued_book) }
    before do
      allow(view).to receive(:current_user).and_return(users(:employee))
      assign(:book, book)
    end

    it 'shows who the book is issued to ' do
      expect(page).to have_content('Issued by')
      expect(page).to have_content(book.user.first_name + ' ' + book.user.last_name)

    end

    it 'shows a check in button' do
      expect(page).to have_button('Check In')
    end

  end

  context 'when the book is not checked out' do
    let(:book) { books(:unissued_book) }
    before do
      allow(view).to receive(:current_user).and_return(users(:employee))
      assign(:book, book)
    end

    it 'shows no body has issued the book' do
      expect(page).to have_content('Issued by')
      expect(page).to have_content('None')
    end

    it 'shows a check in button' do
      expect(page).to have_button('Check Out')
    end
  end
end
