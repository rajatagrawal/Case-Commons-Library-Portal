require 'spec_helper'

describe 'layouts/application' do
  fixtures :all
  let(:page) { Capybara.string(render) }
  before do
    allow(view).to receive(:current_user).and_return(users(:employee))
  end

  context 'if the user is signed in' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
    end

    it "shows a greeting message with the user's name in a link" do
      expect(page).to have_css('a',text: "#{users(:employee).full_name}")
    end

    it 'has a sign out link' do
      expect(page).to have_css('a',text: 'Sign Out')
    end

    it 'has a link to the user profile page' do
      expect(page).to have_css('a',text: 'Go to profile page')
    end
  end

  context 'if the user is not signed in' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end
    it 'does not have a sign out link' do
      expect(page).to_not have_css('a',text: 'Sign Out')
    end

    it 'does not have a link to the user profile page' do
      expect(page).to_not have_css('a',text: 'Go to profile page')
    end
  end

end
