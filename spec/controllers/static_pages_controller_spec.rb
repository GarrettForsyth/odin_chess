require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET home' do
    it 'renders the home page' do
      get :home
      expect(response).to render_template('home')
    end
  end

  describe 'GET lobby' do
    context 'user is not signed in' do
      it 'redirects to the sign in page' do
        get :lobby
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'the user is signed in' do
      before :each do
        @user = FactoryBot.create(:confirmed_user)
        sign_in @user
      end

      it 'renders the lobby template' do
        get :lobby
        expect(response).to render_template('lobby')
      end
    end
  end
end
