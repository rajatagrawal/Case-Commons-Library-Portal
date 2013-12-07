require 'spec_helper'

describe ApplicationController do
  fixtures :all

  describe 'GET #error' do
    before do
      sign_in(users(:admin))
      get :error
    end

    it 'renders the error page' do
      expect(response).to render_template('error')
    end
  end

  describe 'CanCan exception' do
    before do
      sign_in(users(:admin))
      allow(controller).to receive(:welcome).and_raise(CanCan::AccessDenied)
      get :welcome
    end
    it 'renders the error page' do
      expect(response).to redirect_to(action: :error)
    end
  end
end
