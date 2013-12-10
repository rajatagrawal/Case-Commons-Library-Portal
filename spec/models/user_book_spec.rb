require 'spec_helper'

describe UserBook do
  it 'belongs to a user' do
    expect(subject).to belong_to :user
  end

  it 'belongs to a book' do
    expect(subject).to belong_to :book
  end

  it 'should validate presense of the user' do
    expect(subject).to validate_presence_of :user
  end

  it 'should validate presense of the user' do
    expect(subject).to validate_presence_of :book
  end

  it 'should validate presense of the user' do
    expect(subject).to validate_presence_of :issued_on
  end
end
