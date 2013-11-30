require 'spec_helper'

describe 'users/profile' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'when the logged in user is admin' do
    let(:user) { users(:admin) }

    before do
      assign(:user, user)
    end

    it 'shows the add a new book button' do
      expect(page).to have_button('Add a book')
    end

    it 'shows the delete a book button' do
      expect(page).to have_button('Delete a book')
    end

    it 'shows edit a book button' do
      expect(page).to have_button('Edit a book')
    end
  end
end
