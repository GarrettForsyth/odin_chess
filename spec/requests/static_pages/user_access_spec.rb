require 'rails_helper'

describe 'user access', type: :request do
  let(:user) { FactoryBot.create :confirmed_user }
  context 'user is logged in' do
    before :each do
      sign_in user
    end
    describe 'accessing the home page' do
      it 'renders the home template' do
        get root_path
        expect(response).to render_template :home
      end
    end

    describe 'accessing the lobby page' do
      it 'renders the lobby template' do
        get lobby_path
        expect(response).to render_template :lobby
      end
    end
  end

  context 'user is not logged in' do
    describe 'accessing the home page' do
      it 'renders the home template' do
        get root_path
        expect(response).to render_template :home
      end
    end

    describe 'accessing the lobby page' do
      it 'redirects to the sign in path' do
        get lobby_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
