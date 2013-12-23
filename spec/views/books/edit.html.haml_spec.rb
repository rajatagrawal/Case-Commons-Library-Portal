require 'spec_helper'

describe 'books/edit' do

  fixtures :all

  let(:page) { Capybara.string(render) }
  before do
    allow(view).to receive(:current_user).and_return(users(:admin))
    assign(:book, Book.first)
  end

  context 'page layout' do
    it 'shows the header' do
      expect(page).to have_css('h2', 'Edit the book')
    end

    it 'shows the labels for the input fields' do
      expect(page).to have_content('Enter the title for the book')
      expect(page).to have_content('Enter the author for the book')
      expect(page).to have_content('Enter the publisher for the book')
      expect(page).to have_content('Enter the price for the book')
      expect(page).to have_content('Enter the quantity for the book')
    end
  end

  context 'when there are validation errors on the object' do
    before do
      error_message = 'this is an error'
      book = books(:book1)
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
