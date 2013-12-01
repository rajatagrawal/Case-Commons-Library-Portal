require 'spec_helper'

feature 'users' do

  fixtures :all
  scenario 'Admin adds a book' do
    login_in_as users(:admin)
    expect(page).to have_button('Add a user')
    click_button 'Add a user'
    expect(current_path).to eq new_user_path
    fill_in 'Enter First Name', with: 'NewUserFirstName'
    fill_in 'Enter Last Name', with: 'NewUserLastName'
    fill_in 'Enter email address', with: 'new_user@library.casecommons.org'
    check('Admin')
    click_button 'Add User'
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:admin))
    expect(page).to have_content('Added a new user successfully')
    visit users_path
    expect(page).to have_content('NewUserFirstName')
  end

end
