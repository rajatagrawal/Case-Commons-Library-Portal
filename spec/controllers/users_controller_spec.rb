require 'spec_helper'

describe 'get #show' do

  context 'when the user is not admin' do
    before do
      sign_in(users(:employee))
      get :show, id: user.id
    end
    let(:user) { users(:employee)}
    it 'does not show the person page' do
      expect(response).to render_template('show')
    end

    it 'shows an error page' do
    end
  end

  context 'when the user is admin' do
    let(:user) { users(:admin)}
    it 'shows the person page' do

    end

  end


end
