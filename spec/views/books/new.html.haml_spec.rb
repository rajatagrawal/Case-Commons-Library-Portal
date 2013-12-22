require 'spec_helper'

describe 'books/new' do
  let(:page) { Capybara.string(render) }

  let(:book) { Book.new }


  context 'page layout' do
    before do
      assign(:book, book)
    end
    it 'shows the labels for the fields' do
      expect(page).to have_content('Enter the Title of the book')
      expect(page).to have_content('Enter the Author of the book')
      expect(page).to have_content('Enter the Publisher of the book')
      expect(page).to have_content('Enter the Price of the book')
      expect(page).to have_content('Enter the quantity of the book')
    end

    it 'has an add the book button' do
      expect(page).to have_button('Add the book')
    end

    it 'displays the heading of the page' do
      expect(page).to have_css('h2','Add a Book')
    end
  end

  context 'when there are validation errors on the object' do
    before do
      error_message = 'this is an error'
      book.errors.add(:error_key,error_message)
      assign(:book,book)
    end

    it 'shows the validation errors heading' do
      expect(page).to have_content 'Please review the errors below'
    end

    it 'shows the individual validation errors' do
      expect(page).to have_content 'Error key this is an error'
    end
  end
end
