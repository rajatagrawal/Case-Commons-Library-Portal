require 'spec_helper'

feature 'book', js:true do
  fixtures :all

  scenario 'issue a book' do
    login_in_as users(:employee)
    click_link 'Check out a book'
    expect(current_path).to eq books_path
    binding.pry
    book = Book.first
    within page.first('tr',text: book.title) do
      page.find_button('Checkout').click
    end
    expect(current_path).to eq book_path(book)
    page.find_button('Checkout').click
    expect(current_path).to eq user_profile_path(users(:employee))
    expect(page).to have_content(book.title)
  end
end
