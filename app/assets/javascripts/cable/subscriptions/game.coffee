App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    ($('#main-container')).empty()
    render_board()
    setup_board()
    switch data.action
      when 'game_start'
        App.board.position('start')
        App.board.orientation(data.msg.color)

      when 'make_move'
        [source, target] = data.msg.color.split('-')

        App.board.move(data.msg.color)
        App.chess.move
          from: source
          to: target
          promotion: 'q'

render_board = () ->
  board = document.createElement('div')
  board.setAttribute('id', 'chessboard')
  board.setAttribute('style', 'width:400px')
  $('#main-container').append(board)

setup_board = () ->
  App.chess = new Chess()

  cfg =
    position: 'start'
    onDrop: (source, target) =>
      move = App.chess.move
        from: source
        to: target
        promotion: "q"

      if (move == null)
        # illegal move
        return "snapback"
      else
        App.game.perform("make_move", move)

  App.board = ChessBoard("chessboard", cfg)
  alert('word')
