# Odin Chess

[live](https://odin-chess.herokuapp.com)

A simple live chess server.

Users sign up and create seeks. If another user accepts a seek, a game is setup between the users.

This app uses [chessboard.js](http://chessboardjs.com/) for the board, and [chess.js](https://github.com/jhlywa/chess.js/blob/master/README.md) to implement the chess logic.

Rails active cable sends live updates to the users when a move on the board is made, so the game is played in real time.


