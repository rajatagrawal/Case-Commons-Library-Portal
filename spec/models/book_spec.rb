require 'spec_helper'

describe Book do

  it 'should validate the presence of its fields' do
    expect(subject).to validate_presence_of :title
    expect(subject).to validate_presence_of :author
    expect(subject).to validate_presence_of :publisher
    expect(subject).to validate_presence_of :price
  end

  it 'belongs to a user' do
    expect(subject).to belong_to(:user)
  end

end

describe '#checked_out?' do
  let(:book) { Book.new }

  context 'if the book is issued' do
    it 'should return true' do
      book.user = User.new
      expect(book.checked_out?).to be(true)
    end

  end

  context 'if the book is not issued' do
    it 'should return false' do
      expect(book.checked_out?).to eq(false)
    end
  end

end
