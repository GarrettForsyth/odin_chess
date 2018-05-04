require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'POST create' do
    context 'with valid parameters' do
      before :each do
        @params = { game: {
          player1: FactoryBot.create(:confirmed_user),
          player2: FactoryBot.create(:confirmed_user),
          timecontrol: '5'
        } }
      end

      it 'creates a new game' do
        expect { post(:create, params: @params) }.to change(Game, :count).by(1)
      end

      it 'broadcast a to each player' do
        expect { post(:create, params: @params) }
          .to have_broadcasted_to("player_#{@params[:game][:player1].handle}")
        expect { post(:create, params: @params) }
          .to have_broadcasted_to("player_#{@params[:game][:player2].handle}")
      end
    end
    context 'with invalid paramters' do
      before :each do
        @params = { game: {
          player1: FactoryBot.create(:confirmed_user),
          player2: FactoryBot.create(:confirmed_user),
          timecontrol: '-5'
        } }
      end

      it 'creates a new game' do
        expect { post(:create, params: @params) }.to change(Game, :count).by(0)
      end

      it 'to not broadcast a to each player' do
        expect { post(:create, params: @params) }
          .to_not have_broadcasted_to("player_#{@params[:game][:player1].handle}")
        expect { post(:create, params: @params) }
          .to_not have_broadcasted_to("player_#{@params[:game][:player2].handle}")
      end
    end
  end

  describe 'PUT make_move' do
    before :each do
      @game = FactoryBot.create(:game)
      $redis.set("opponent_for_#{@game.white_user.handle}", @game.black_user.handle)
      $redis.set("opponent_for_#{@game.black_user.handle}", @game.white_user.handle)
    end

    context 'with valid parameters' do
      it 'broadcast to the players opponent' do
        data = { move: { from: 'e2', to: 'e4' } }
        params = { id: @game.id, player: @game.white_user, data: data }
        expect { put :update, params: params }
          .to have_broadcasted_to("player_#{@game.black_user.handle}")
      end
    end
    xcontext 'with invalid paramters' do
    end
  end

  describe 'DELETE destroy' do
    context 'with valid paramters' do
      context 'out come is forfeit' do
        before :each do
          @game = FactoryBot.create(:game)
          @params = { id: @game.id, outcome: 'forfeit', player: @game.white_user }
          $redis.set("opponent_for_#{@game.white_user.handle}", @game.black_user.handle)
          $redis.set("opponent_for_#{@game.black_user.handle}", @game.white_user.handle)
        end

        it 'deletes the game' do
          expect { delete :destroy, params: @params }
            .to change(Game, :count).by(-1)
        end

        it 'broadcast the outcome to the opponent' do
          expect { delete :destroy, params: @params }
            .to have_broadcasted_to("player_#{@game.black_user.handle}")
        end
      end
      context 'with invalid paramters' do
      end
    end
  end
end
