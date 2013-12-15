require 'spec_helper'

describe 'users/profile' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'page contents' do
    let(:user) {
      user = User.new
      user.first_name = 'First Name'
      user.last_name = 'Last Name'
      user
    }

    before do
      assign(:user, user)
    end
    it "shows a greeting message with the user's name" do
      expect(page).to have_content("Hi #{user.full_name} !")
    end

  end

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

    it 'shows add a user button' do
      expect(page).to have_button('Add a user')
    end

    it 'shows edit a user button' do
      expect(page).to have_button('Edit a user')
    end

    it 'shows delete a user button' do
      expect(page).to have_button('Delete a user')
    end
  end
end
