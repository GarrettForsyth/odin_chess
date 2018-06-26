class GamesController < ApplicationController
  def create
    @white, @black = [User.find(params[:game][:player1]),
                      User.find(params[:game][:player2])].shuffle
    @game = Game.new(white_user: @white,
                     black_user: @black,
                     timecontrol: params[:game][:timecontrol])
    if @game.save
      Game.broadcast_start(@white, @black, game_url(@game.id))
      @white.seeks.destroy_all
      @black.seeks.destroy_all
    else
      flash[:error] = 'Game could not be created.'
    end
  end

  def update
    # TODO: only run this code if passes serverside validation
    player = User.find(params[:player])
    move = Game.move_to_string(params[:data][:move])
    Game.broadcast_move(player, move)
  end

  def destroy
    @game = Game.find(params[:id])
    player = User.find(params[:player])
    case params[:outcome]
    when 'forfeit'
      Game.broadcast_forfeit(player)
    end
    @game.destroy
  end

  private

  def game_params
    params.require(:game).permit(:player1, :player2, :timecontrol)
  end

  def game_put_parameters
    params.require(:game).permit(:id, :player, :data)
  end
end
