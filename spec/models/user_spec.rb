require 'spec_helper'

describe User do

  it 'should validate presence of its fields' do
    expect(subject).to validate_presence_of :first_name
    expect(subject).to validate_presence_of :last_name
    expect(subject).to validate_presence_of :email
    expect(subject).to validate_presence_of :role
  end

  it 'has books' do
    expect(subject).to have_many :books
  end

end

describe '#admin?' do

  let(:user) {User.new}

  context 'when the user is admin' do
    it 'returns true' do
      user.role = 'admin'
      expect(user.admin?).to eq true
    end
  end

  context 'when the user is not admin' do
    it 'returns false' do
      user.role = 'employee'
      expect(user.admin?).to eq false
    end
  end
end
