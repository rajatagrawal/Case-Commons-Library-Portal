require 'spec_helper'

feature 'book', js:true do
  fixtures :all

  scenario 'issue a book' do
    login_in_as users(:employee)
    click_link 'Check out a book'
    expect(current_path).to eq books_path
    book = Book.first
    within page.first('tr',text: book.title) do
      page.find_button('Checkout').click
    end
    expect(current_path).to eq book_path(book)
    page.find_button('Checkout').click
    expect(current_path).to eq user_profile_path(users(:employee))
    expect(page).to have_content(book.title)
  end

  scenario 'check in a book' do
    login_in_as users(:employee_with_checked_out_books)
    expect(page.find_button('Check In')).to be
    click_button 'Check In'
    expect(current_path).to eq book_path(books(:issued_book))
    click_button 'Check In'
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:employee_with_checked_out_books))
    expect(page).to_not have_button('Check In')
  end
end
