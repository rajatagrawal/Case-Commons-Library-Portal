require 'spec_helper'

describe 'users/index' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'when an admin user is logged in' do
    before do
      allow(view).to receive(:current_user).and_return(users(:admin))
      assign(:users,[users(:employee),users(:employee2)])
    end

    it 'shows table header to edit a user' do
      expect(page).to have_content('Edit User?')
    end
    it 'shows an edit user button' do
      expect(page).to have_button('Edit User')
    end
    it 'shows table header to delete a user' do
      expect(page).to have_content('Delete User?')
    end
    it 'shows a delete user button' do
      expect(page).to have_button('Delete User')
    end
  end
end
