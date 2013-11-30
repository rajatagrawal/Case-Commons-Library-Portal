require 'spec_helper'

describe 'books/index' do
  let(:page) {Capybara.string(render)}

  fixtures :all
  context 'when an admin user is logged in' do
    before do
      allow(view).to receive(:current_user).and_return(users(:admin))
      assign(:books,[books(:book1),books(:book2)])
    end

    it 'shows a delete button' do
      expect(page).to have_button('Delete Book')
    end

    it 'shows a table header to delete the book' do
      expect(page).to have_css('th', text: 'Delete Book?')
    end
  end
end

