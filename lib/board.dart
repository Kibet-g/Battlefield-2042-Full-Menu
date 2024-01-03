import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/piece.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

/*
THE GAME BOARD
A 2 BY 2 GRID WITH NULL REPRESENTING AN EMPTY SPACE
A NON EMPTY SPACE WILL HAVE THE COLOR TO REPRESENT THE LANDED PIECES

 */
//NOW LETS CREATE THE GAME BOARD

List<List<Tetromino?>>gameBoard = List.generate
  (collength,
        (i) => List.generate(
    rowLength,
(j)=> null,
        ),
);
class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {


  //LETS CREATE THE CURRENT TETRIS PIECE
  //LETS CREATE THE CURRENT TETRIS PIECE
  Piece currPiece = Piece(type: Tetromino.L);
  //CURRENT SCORE VARIABLE
  int currentscore=0;

  @override
  void initState() {
    super.initState();
    //we start the game when the app starts
    startGame();
  }

  void startGame() {
    currPiece.initializePiece();
    //our frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }
  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
          (timer) {
        setState(() {
          //clear the lines
          clearLines();
          // This will move the piece down
          currPiece.movePiece(Direction.down);
          // let us check for the landing
          checkLanding();
        });
      },
    );
  }

  //WE NEED TO CHECK THE FUTURE POSITIONS
  //RETURNS TRUE INCASE OF A COLLISION AND FALSE INCASE THERE IS NONE
  bool checkCollision(Direction direction) {
    //loop through each position of the current piece
    for (int i = 0; i < currPiece.position.length; i++) {
      //calculate the row and collumn for the current piece
      int row = (currPiece.position[i] / rowLength).floor();
      int col = currPiece.position[i] % rowLength;
      // Check for collision with existing pieces
      if (gameBoard[row][col] != null) {
        return true;
      }

      //Now lets adjust the row and collumn based on the direction
      if (direction == Direction.left) {
        col -= 1;
      }
      else if (direction == Direction.right) {
        col += 1;
      }
      else if (direction == Direction.down) {
        row += 1;
      }
      //check if the piece is out of bounce this means if its either too left too right or too low
      if (row >= collength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    // if no collisions detected we will return false
    return false;
  }

  //we also check the tetris box landing and say
  void checkLanding() {
    if (checkCollision(Direction.down)) {
      //we mark the position as occupied by the game board
      for (int i = 0; i < currPiece.position.length; i++) {
        int row = (currPiece.position[i] / rowLength).floor();
        int col = currPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currPiece.type;
        }
      }
      //ONCE LANDED CREATE THE NEXT PIECE
      createNewPiece();
    }
  }

  void createNewPiece() {
    //create a random object to generate random tetromino types
    Random rand = Random();
    //create the new piece with any random type of integer value
    Tetromino randomType = Tetromino.values[rand.nextInt(
        Tetromino.values.length)];
    currPiece = Piece(type: randomType);
    currPiece.initializePiece();
  }

  //Left
  void moveLeft() {
    //Make sure the move is valid before moving to the position you want
    if (!checkCollision(Direction.left)) {
      setState(() {
        currPiece.movePiece(Direction.left);
      });
    }
  }

///Right
  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currPiece.movePiece(Direction.right);
      });
    }
  }

// Rotate
  void rotatePiece() {
    currPiece.rotatePiece();
  }
  //clear the lines
  void clearLines(){
    // 1:Loop through each row if the game from top to bottom
    for (int row= collength-1; row>=0; row--){
      //2: Do an initialization to by creating a variable to find if the row is full
      bool rowIsFull=true;
      //3:Check if the row is full all columns are filled with piece
      for(int col=0; col<rowLength; col++) {
        //now if there is an empty collumn set the row is full to false then break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      //4: If the row is full clear the row and shift down the rows
      if (rowIsFull){
        //5: We move all the cleared rows above the cleared row down by one position
        for(int r=row; r>0; r--){
          //we do copy the above row to the current row
          gameBoard[r]=List.from(gameBoard[r-1]);
        }
        //6: We now set the top row  to be empty
        gameBoard[0]=List.generate(row, (index) => null);
        //7: Increase the score
        currentscore++;
      }
    }

  }
  //Game over method
  bool isGameOver(){
    //check if there are any collumns in the top which are filled
    for(int col=0; col<rowLength; col++){
      if (gameBoard[0][col] !=null){
        return true;
      }
    }
    //if the top row is empty the game is not over
    return false;
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            //GAME CONTROLS
            Expanded(
              child: GridView.builder(
                itemCount: rowLength * collength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength,
                ),
                // This is the slivergridelegatewithCrossAxisCount
                itemBuilder: (context, index) {
                  //Get the row and collumn for the current piece
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  //The current piece
                  if (currPiece.position.contains(index)) {
                    return Pixel(
                      color: currPiece.color,
                      child: index,
                    );
                  }
                  //AFTER LANDING IT IS A BLANK PIXEL
                  else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                        color: tetrominoColors[tetrominoType], child: '');
                  }
                  else {
                    return Pixel(color: Colors.grey[900],
                      child: index,
                    );
                  }
                },

              ),
            ),
            //Game controls
            //SCORE
            Text('Score:$currentscore',
            style: const TextStyle(color: Colors.white),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 50.0, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //left
                  IconButton(onPressed: moveLeft,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  //rotate
                  IconButton(onPressed: rotatePiece,
                      color: Colors.white,
                      icon: const Icon(Icons.rotate_right)),
                  //right
                  IconButton(onPressed: moveRight,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_forward_ios)),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

