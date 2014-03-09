require 'spec_helper'

describe 'users/new' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'page layout' do
    before do
      user = users(:admin)
      assign(:user, User.new)
      allow(view).to receive(:current_user).and_return(user)
    end

    it 'shows the page heading' do
      expect(page).to have_css('h2', 'Create a new user')
    end

    it 'shows the label and input field for user first name' do
      expect(page).to have_content('Enter First Name')
      expect(page).to have_css('input[id=user_first_name]')
    end

    it 'shows the label and input field for user last name' do
      expect(page).to have_content('Enter Last Name')
      expect(page).to have_css('input[id=user_last_name]')
    end

    it 'shows the label and input field for user first name' do
      expect(page).to have_content('Enter Email Address')
      expect(page).to have_css('input[id=user_email]')
    end

    it 'shows the label to enter user role' do
      expect(page).to have_content('Role')
    end

    it 'shows the options for entering the role of the user' do
      expect(page).to have_content('employee')
      expect(page).to have_content('admin')
    end

    it 'shows the label for entering the password' do
      expect(page).to have_content('Password')
    end

    it 'the password field is a required field' do
      expect(page).to have_css('div.user_password > input.required')
    end

    it 'shows the label for entering password confirmation' do
      expect(page).to have_content('Password Confirmation')
    end

    it 'the confirmation password field is a required field' do
      expect(page).to have_css('div.user_password_confirmation > input.required')
    end

    it 'shows a create a user button' do
      expect(page).to have_button('Add User')
    end
  end

  context 'when there are validation errors on the object' do
    before do
      user = User.new
      error_message = 'this is an error'
      user.errors.add(:error_key,error_message)
      assign(:user,user)
      allow(view).to receive(:current_user).and_return(users(:admin))
    end

    it 'shows the validation errors heading' do
      expect(page).to have_content 'Please review the errors below'
    end

    it 'shows the individual validation errors' do
      expect(page).to have_content 'Error key this is an error'
    end
  end
end
