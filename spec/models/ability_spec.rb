require 'spec_helper'
require 'cancan/matchers'

describe 'abilities of the user' do
  fixtures :all
  let(:abilities) { Ability.new(user) }

  context 'on the book object' do
    let(:user) { users(:employee) }
    it 'should be able to check in a book' do
      expect(abilities).to be_able_to(:checkin, books(:book1))
    end
    it 'should be able to check out a book' do
      expect(abilities).to be_able_to(:checkout, books(:book1))
    end

    context('when the user is not an admin') do
      let(:user) { users(:employee) }
      it 'should be able to read a book' do
        expect(abilities).to be_able_to(:read, books(:book1))
      end
      it 'should not be able to manage a book' do
        expect(abilities).to_not be_able_to(:manage, books(:book1))
      end
    end

    context 'when the user is an admin' do
      let(:user) { users(:admin) }

      it 'should be able to read a book' do
        expect(abilities).to be_able_to(:read, books(:book1))
      end
      it 'should be able to manage a book' do
        expect(abilities).to be_able_to(:manage, books(:book1))
      end
    end
  end

  context 'on the user object' do
    let(:user2) { users(:employee2) }
    context 'when the user is not an admin' do
      let(:user) { users(:employee)}
      it 'should be able to see only her user show page' do
        expect(abilities).to be_able_to(:read, user)
      end
      it 'should not be able to read other users' do
        expect(abilities).to_not be_able_to(:read, user2)
      end
      it 'should not be able to manage users' do
        expect(abilities).to_not be_able_to(:manage, user)
      end

      it 'should be able to see only her profile page' do
        expect(abilities).to be_able_to(:profile, user)
        expect(abilities).to_not be_able_to(:profile, user2)
      end
    end

    context 'when the user is an admin' do
      let(:user) { users(:admin)}
      it 'should be able to manage users' do
        expect(abilities).to be_able_to(:manage, user)
        expect(abilities).to be_able_to(:manage, user2)
      end
    end
  end
end
