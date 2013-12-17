require 'spec_helper'

describe 'books/show' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'when the book is checked out' do
    let(:book) { books(:unreturned_issued_book) }
    before do
      allow(view).to receive(:current_user).and_return(users(:employee))
      assign(:book, book)
    end

    it 'shows who the book is issued to ' do
      expect(page).to have_content('Issued by')
      book.current_users.each do |book_user|
        expect(page).to have_content(book_user.first_name + ' ' + book_user.last_name)
      end
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

  end
end
