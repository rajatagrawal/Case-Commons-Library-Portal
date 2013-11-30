require 'spec_helper'

feature 'login page', js: true do
  fixtures :users

  scenario 'user logs in successfully' do
    visit new_user_session_path
    fill_in 'Email', with: users(:employee).email
    fill_in 'Password', with: 'Password123'
    click_button('Sign in')
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'user logs in unsuccessfully' do
    visit new_user_session_path
    fill_in 'Email', with: users(:employee).email
    fill_in 'Password', with: 'wrong_password'
    click_button('Sign in')
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Invalid email or password.')
  end
end
