require 'spec_helper'

describe 'users/edit' do
  fixtures :all
  let(:page) { Capybara.string(render) }

  context 'page layout' do
    before do
      assign(:user, users(:employee))
      allow(view).to receive(:current_user).and_return(users(:admin))
    end

    it 'displays the header to edit the user' do
      expect(page).to have_css('h2','Edit User')
    end

    it 'shows the label and the input field to edit the first name of the person' do
      expect(page).to have_content('Enter First Name')
      expect(page).to have_css('input[id=user_first_name]')
    end

    it 'shows the label and the input field to edit the last name of the person' do
      expect(page).to have_content('Enter Last Name')
      expect(page).to have_css('input[id=user_last_name]')
    end

    it 'shows the label and the input field to edit the email address of the person' do
      expect(page).to have_content('Enter Email Address')
      expect(page).to have_css('input[id=user_email]')
    end

    it 'shows a label and radio buttons to edit user privileges' do
      expect(page).to have_content('Role')
      expect(page).to have_content('admin')
      expect(page).to have_content('employee')
    end

    it 'shows a button to update the user' do
      expect(page).to have_button('Update user')
    end

    it 'shows a button to go back to the profile page' do
      expect(page).to have_button('Cancel')
    end

  end

  context 'when there are validation errors on the object' do
    before do
      error_message = 'this is an error'
      user = users(:employee2)
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
