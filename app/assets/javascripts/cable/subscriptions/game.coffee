App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log('here!!')
    switch data.action
      when 'game_start'
        ($('#main-container')).empty()
        render_board()
        setup_board()
        App.board.position('start')
        App.board.orientation(data.msg.color)
        return
      when 'make_move'
        App.chess.move
          from: data.msg.from
          to: data.msg.to
          promotion: 'q'
        App.board.position(App.chess.fen())
        return

render_board = () ->
  board = document.createElement('div')
  board.setAttribute('id', 'chessboard')
  board.setAttribute('style', 'width:400px')
  $('#main-container').append(board)

setup_board = () ->
  App.chess = new Chess()

  cfg =
    position: 'start',
    draggable: true,

    # no drag on game end
    # no drag on opponents turn
    onDragStart: (source, piece, position, orientation) ->
      if (App.chess.game_over() == true ||
      (App.chess.turn() == 'w' && piece.search(/^b/) != -1) ||
      (App.chess.turn() == 'b' && piece.search(/^w/) != -1))
        return false

    onDrop: (source, target) ->
      move = App.chess.move
        from: source
        to: target
        promotion: "q"

      # illegal move
      if (move == null)
        return "snapback"
      else
        App.game.perform("make_move", move)

    # update for castling and en passant, pawn promotion
    onSnapEnd: () ->
      App.board.position(App.chess.fen())

  App.board = ChessBoard("chessboard", cfg)
