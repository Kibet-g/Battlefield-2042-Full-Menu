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
  Piece currPiece =Piece(type: Tetromino.T);

  @override
  void initState(){
    super.initState();
    //we start the game when the app starts
    startGame();
  }
  void startGame(){
    currPiece.initializePiece();
    //our frame refresh rate
    Duration frameRate=const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }
  void gameLoop(Duration frameRate){
    Timer.periodic(
      frameRate,
        (timer){
        setState(() {
          //let us check for the landing
          checkLanding();
          //This will move the piece down
          currPiece.movePiece(Direction.down);
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
    if (checkCollision(Direction.down)){
      //we mark the position as occupied by the game board
      for(int i=0; i<currPiece.position.length; i++){
        int row = (currPiece.position[i]/rowLength).floor();
        int col = currPiece.position[i] % rowLength;
        if(row>=0 && col>=0){
          gameBoard[row][col]=currPiece.type;

        }
      }
      //ONCE LANDED CREATE THE NEXT PIECE
      createNewPiece();
    }
    }
    void createNewPiece(){
    //create a random object to generate random tetromino types
      Random rand= Random();
      //create the new piece with any random type of integer value
      Tetromino randomType= Tetromino.values[rand.nextInt(Tetromino.values.length)];
      currPiece=Piece(type: randomType);
      currPiece.initializePiece();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: rowLength*collength,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowLength,
        ),
        // This is the slivergridelegatewithCrossAxisCount
        itemBuilder: (context, index) {
          //Get the row and collumn for the current piece
          int row = (index/rowLength).floor();
          int col = index % rowLength;

          //The current piece
          if(currPiece.position.contains(index)) {
            return Pixel(
              color: Colors.yellow,
              child: index,
            );
          }
          //AFTER LANDING IT IS A BLANK PIXEL
          else if (gameBoard[row][col] !=null)
            {
              return Pixel(color: Colors.pink, child: '');
            }
          else{
            return Pixel(color: Colors.grey[900],
              child: index,
            );
          }
  },

        ),
      );
  }
}

