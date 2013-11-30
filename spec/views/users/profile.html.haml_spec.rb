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
      binding.pry
      expect(page).to have_button('Add a book')
    end
  end
end
