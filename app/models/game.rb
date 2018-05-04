class Game < ApplicationRecord
  belongs_to :white_user, class_name: 'User'
  belongs_to :black_user, class_name: 'User'

  validates :timecontrol, numericality: { greater_than: 0 }
  validate :users_confirmed?

  def self.broadcast_start(white, black, game_url)
    ActionCable.server.broadcast "player_#{white.handle}",
                                 action: 'game_start',
                                 msg: {color: 'white', game_url: game_url}
    ActionCable.server.broadcast "player_#{black.handle}",
                                 action: 'game_start',
                                 msg: {color: 'black', game_url: game_url}
    # Store in REDIS so when a move is made, a quick look up
    # of the opponent can occur
    $redis.set("opponent_for_#{white.handle}", black.handle)
    $redis.set("opponent_for_#{black.handle}", white.handle)
  end

  def self.broadcast_move(player, move)
    opponent = $redis.get("opponent_for_#{player.handle}")

    ActionCable.server.broadcast "player_#{opponent}",
                                 action: 'make_move',
                                 msg: move
  end

  def self.move_to_string(move)
    # TODO: figure out some wayto validate the move is legal
    # on the server side
    "#{move[:from]}-#{move[:to]}"
  end

  def self.broadcast_forfeit(player)
    opponent = $redis.get("opponent_for_#{player.handle}")
    ActionCable.server.broadcast "player_#{opponent}",
                                 action: 'opponent_forfeits'
  end

  private

  def users_confirmed?
    errors.add(:white_user, 'must be confirmed') unless white_user && white_user.confirmed?
    errors.add(:black_user, 'must be confirmed') unless black_user && black_user.confirmed?
  end
end
