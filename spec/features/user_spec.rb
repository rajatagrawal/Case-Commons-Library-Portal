require 'spec_helper'

feature 'users',js:true do

  fixtures :all
  scenario 'Admin adds a user' do
    login_in_as users(:admin)
    expect(page).to have_css('a','Add a user')
    click_link 'Add a user'
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
    expect(page).to have_css('a','Edit a user')
    click_link 'Edit a user'
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

  scenario 'Admin deletes a user' do
    login_in_as users(:admin)
    expect(page).to have_css('a', text: 'Delete a user')
    click_link 'Delete a user'
    expect(current_path).to eq users_path
    user = User.first
    row = page.find('tr', text: user.first_name)
    within row do
      click_button 'Delete User'
    end
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:admin))
    expect(page).to have_content('Successfully deleted the user.')
    visit users_path
    expect(page).to_not have_content(user.first_name)
  end

end
