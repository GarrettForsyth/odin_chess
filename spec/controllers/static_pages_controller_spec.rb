require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET home' do
    before do
      get :home
    end

    it 'renders the home page' do
      expect(response).to render_template('home')
    end

    it 'renders the application layout' do
      expect(response).to render_template('layouts/application')
    end
  end

  describe 'GET lobby' do

    it 'renders the sign in page when user is not logged in' do
      get :lobby
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'renders the lobby if the user is signed in'  do
      user = FactoryBot.create(:user)
      sign_in user
      get :lobby
      expect(response).to render_template('lobby')
    end
  end
end
