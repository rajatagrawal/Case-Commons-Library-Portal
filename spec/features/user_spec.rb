require 'spec_helper'

feature 'users',js:true do

  fixtures :all
  scenario 'Admin adds a user' do
    login_in_as users(:admin)
    expect(page).to have_button('Add a user')
    click_button 'Add a user'
    expect(current_path).to eq new_user_path
    fill_in 'Enter First Name', with: 'NewUserFirstName'
    fill_in 'Enter Last Name', with: 'NewUserLastName'
    fill_in 'Enter Email Address', with: 'new_user@library.casecommons.org'
    fill_in 'user_password', with: 'FakePassword1234'
    fill_in 'user_password_confirmation', with: 'FakePassword1234'
    choose('admin')
    click_button 'Add User'
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:admin))
    expect(page).to have_content('Added a new user successfully.')
    visit users_path
    expect(page).to have_content('NewUserFirstName')
  end

  scenario 'Admin edits a user' do
    login_in_as users(:admin)
    expect(page).to have_button('Edit a user')
    click_button 'Edit a user'
    expect(current_path).to eq users_path
    user = User.first
    row = page.find('tr', text: user.first_name)
    within row do
      click_button 'Edit User'
    end
    expect(current_path).to eq edit_user_path(user)
    fill_in 'Enter First Name', with: 'Updated First Name'
    click_button 'Update user'
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:admin))
    expect(page).to have_content('Successfully updated the user.')
    visit users_path
    expect(page).to have_content('Updated First Name')
  end

end
