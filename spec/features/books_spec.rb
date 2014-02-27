require 'spec_helper'

feature 'book', js:true do
  fixtures :all

  scenario 'issue a book' do
    login_in_as users(:employee)
    click_link 'check out'
    expect(current_path).to eq books_path
    book = books(:unissued_book)
    within page.first('tr',text: book.title) do
      page.find_button('Checkout').click
    end
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content('Successfully checked out the book')
    expect(current_path).to eq user_profile_path(users(:employee))
    expect(page).to have_content(book.title)
  end

  scenario 'check in a book' do
    login_in_as users(:employee2_with_checked_out_books)
    expect(page).to have_css('a','Check In')
    click_link 'Check In'
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:employee2_with_checked_out_books))
    expect(page).to_not have_button('Check In')
  end

  scenario 'Admin adds a book' do
    login_in_as users(:admin)
    expect(page).to have_css('a','Add a book')
    click_link 'Add a book'
    expect(current_path).to eq new_book_path
    fill_in 'Enter the Title of the book', with: 'NewBookTitle'
    fill_in 'Enter the Author of the book', with: 'NewBookAuthor'
    fill_in 'Enter the Publisher of the book', with: 'NewBookPublisher'
    fill_in 'Enter the Price of the book', with: 123
    fill_in 'Enter the quantity of the book', with: 3
    click_button 'Add the book'
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:admin))
    expect(page).to have_content('Added a new book successfully')
    visit books_path
    expect(page).to have_content('NewBookTitle')
  end

  scenario 'Admin deletes a book' do
    login_in_as users(:admin)
    expect(page).to have_css('a','Delete a book')
    click_link 'Delete a book'
    expect(current_path).to eq books_path
    book = Book.first
    row = page.find('tr',text: book.title)
    within row do
      click_button 'Delete Book'
    end
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:admin))
    expect(page).to have_content('Successfully deleted the book')
    visit books_path
    expect(page).to_not have_content(book.title)
  end

  scenario 'Admin edits a book' do
    login_in_as users(:admin)
    expect(page).to have_css('a','Edit a book')
    click_link 'Edit a book'
    expect(current_path).to eq books_path
    book = Book.first
    row = page.find('tr',text: book.title)
    within row do
      click_button 'Edit Book'
    end
    expect(current_path).to eq edit_book_path(book)
    fill_in 'Enter the title for the book', with: 'Updated Title'
    click_button 'Save'
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq user_profile_path(users(:admin))
    expect(page).to have_content('Successfully updated the book')
    visit books_path
    expect(page).to have_content('Updated Title')
  end
end
