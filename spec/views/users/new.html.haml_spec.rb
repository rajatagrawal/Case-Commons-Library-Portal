require 'spec_helper'

describe 'users/new' do
  let(:page) { Capybara.string(rendered) }

  before do
    assign(:user, User.new)
  end

  it 'shows the label and input field for user first name' do
    expect(page).to have_content('Enter First Name')
    expect(page).to have_css('input')
  end
end
