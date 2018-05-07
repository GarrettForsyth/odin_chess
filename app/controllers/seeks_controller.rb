class SeeksController < ApplicationController
  def create
    @seek = Seek.new(seek_params)
    @seek.user = current_user
    # Store timecontrol in seconds in the databae
    @seek.timecontrol = (seek_params[:timecontrol].to_i * 60).floor
    if @seek.save
      # Seek should up broadcast right after creation
      ActionCable.server.broadcast 'seeks',
                                   action: 'add',
                                   seek: render_seek(@seek)
      head :ok
    else
      redirect_to lobby_url
    end
  end

  def destroy
    @seek = Seek.find params[:id]
    ActionCable.server.broadcast 'seeks',
                                 action: 'destroy',
                                 seek_id: @seek.id
    @seek.destroy
  end

  def accept
    @seek = Seek.find params[:id]
    white, black = [@seek.user, current_user].shuffle
    game_params = { white_user: white,  black_user:black, timecontrol: @seek.timecontrol }
    if @game = Game.create(game_params)
      Game.broadcast_start(white, black, game_url(@game))
      ActionCable.server.broadcast 'seeks',
                                   action: 'destroy',
                                   seek_id: @seek.id
      @seek.destroy
    else
      flash[:error] = 'Game could not be created.'
    end
  end

  private

  def render_seek(seek)
    render partial: 'seek', locals: { seek: seek }
  end

  def seek_params
    params.require(:seek).permit(:timecontrol, :seeklist_id)
  end
end
