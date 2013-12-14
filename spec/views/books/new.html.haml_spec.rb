require 'spec_helper'

describe 'books/new' do
  let(:page) { Capybara.string(render) }

  let(:book) { Book.new }

  before do
    assign(:book, book)
  end

  it 'shows the labels for the fields' do
    expect(page).to have_content('Enter the Title of the book')
    expect(page).to have_content('Enter the Author of the book')
    expect(page).to have_content('Enter the Publisher of the book')
    expect(page).to have_content('Enter the Price of the book')
    expect(page).to have_content('Enter the quantity of the book')
  end

  it 'has an add the book button' do
    expect(page).to have_button('Add the book')
  end

  it 'displays the heading of the page' do
    expect(page).to have_css('h2','Add a Book')
  end
end
