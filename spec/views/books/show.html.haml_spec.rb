require 'spec_helper'

describe 'books/show' do
  let(:book) do
    stub_model Book, title: 'Book Title'
    stub_model Book, author: 'Book Author'
    stub_model Book, publisher: 'Book Publisher'
    stub_model Book, price: 10
  end
  let(:page) { Capybara.string(render) }

  before(:each) do
    assign :book, book
  end

  it 'shows a checkout button for the book' do
    binding.pry
    expect(page.has_button?('Checkout')).to be_true
  end
end
