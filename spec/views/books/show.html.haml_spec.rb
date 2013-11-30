require 'spec_helper'

describe 'books/show' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'when the book is checked out' do
    let(:book) { books(:issued_book) }
    before do
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
