require 'spec_helper'

feature 'invalid parameters', js: true do
  fixtures :all

  scenario 'invalid book add' do
    login_in_as users(:admin)
    visit new_book_path
    click_button 'Add the book'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Please review the errors below'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Author can't be blank"
    expect(page).to have_content "Publisher can't be blank"
    expect(page).to have_content "Price can't be blank"
  end
end
