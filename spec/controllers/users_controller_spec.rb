require 'spec_helper'

describe UsersController do

  fixtures :all

  describe 'GET #show' do
    context 'when the user is not admin' do
      before do
        sign_in(users(:employee))
        get :show, id: user.id
      end

      context 'and sees own person page' do
        let(:user) { users(:employee)}

        it 'renders the person profile page' do
          expect(response).to render_template('show')
        end

        it 'does not show an error page' do
          expect(response).to_not render_template
        end
      end

      context 'and tries to see a different person page' do
        let(:user) { users(:employee2)}

        it 'does not show the person page' do
          expect(response).to_not render_template('show')
        end

        it 'shows an error' do
          binding.pry
          expect(response.status).to be
        end
      end
    end

    context 'when the user is admin' do
      let(:user) { users(:admin)}
      it 'shows the person page' do

      end
    end
  end
end
