class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{current_user.handle}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    Game.broadcast_forfeit(current_user) # forfeit on a disconnect
  end

  def make_move(data)
    Game.broadcast_move(current_user, data)
  end
end
