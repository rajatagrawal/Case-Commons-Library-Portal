def login_in_as(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'Password123'
  click_button 'Sign in'
  expect(page).to have_content('Signed in successfully.')
end
