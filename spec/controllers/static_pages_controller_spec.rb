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
    before do
      get :lobby
    end

    it 'renders the lobby page' do
      expect(response).to render_template('lobby')
    end

    it 'renders the application layout' do
      expect(response).to render_template('layouts/application')
    end
  end
end
