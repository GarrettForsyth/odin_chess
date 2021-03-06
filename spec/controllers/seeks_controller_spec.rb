require 'rails_helper'

RSpec.describe SeeksController, type: :controller do
  # seek associates its user with the current user
  before(:each) do
    @user = FactoryBot.create(:confirmed_user)
    sign_in @user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new seek' do
        params = { seek: FactoryBot.attributes_for(:seek, seeklist_id: 1) }
        expect { post(:create, params: params) }.to change(Seek, :count).by(1)
      end

      it 'broadcast the seek' do
        params = { seek: FactoryBot.attributes_for(:seek, seeklist_id: 1) }
        expect { post(:create, params: params) }
          .to have_broadcasted_to('seeks')
      end
    end

    context 'with invalid attributes' do
      it 'does not save the seek' do
        params = { seek: FactoryBot.attributes_for(:invalid_seek, seeklist_id: 1) }
        expect { post(:create, params: params) }.to change(Seek, :count).by(0)
      end

      it 'does not broadcast the seek' do
        params = { seek: FactoryBot.attributes_for(:invalid_seek, seeklist_id: 1) }
        expect { post(:create, params: params) }
          .to_not have_broadcasted_to('seeks')
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @seek = FactoryBot.create(:seek, user: @user)
    end

    it 'deletes the seek' do
      expect { delete :destroy, params: { id: @seek } }
        .to change(Seek, :count).by(-1)
    end

    it 'broadcast to seeks channel' do
      expect { delete(:destroy, params: { id: @seek }) }
        .to have_broadcasted_to('seeks')
    end
  end

  describe 'DELETE #accept' do
    before :each do
      @seek = FactoryBot.create(:seek, user: @user)
      @accepting_user = FactoryBot.create(:confirmed_user)
      sign_in @accepting_user
    end

    it 'deletes the seek' do
      expect { delete :accept, params: { id: @seek } }
        .to change(Seek, :count).by(-1)
    end

    it 'broadcast to seeks channel to delete seek from list' do
      expect { delete(:accept, params: { id: @seek }) }
        .to have_broadcasted_to('seeks')
    end

    it 'broadcast to the seeking player' do
      expect { delete(:accept, params: { id: @seek }) }
        .to have_broadcasted_to("player_#{@seek.user.handle}")
    end

    it 'broadcasting to the accepting palyer' do
      expect { delete(:accept, params: { id: @seek }) }
        .to have_broadcasted_to("player_#{@accepting_user.handle}")
    end

    it 'creates a new game' do
      expect { delete(:accept, params: { id: @seek }) }
        .to change(Game, :count).by(1)
    end
  end
end
