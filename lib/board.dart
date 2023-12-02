import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris_game/piece.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  
  //LETS CREATE THE CURRENT TETRIS PIECE
  Piece currPiece =Piece(type: Tetronim.L);

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
        //This will move the piece down
          currPiece.movePiece(Direction.down);
        }
    );
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
          if(currPiece.position.contains(index)) {
            return Pixel(
              color: Colors.yellow,
              child: index,
            );
          }
          else{
            return Pixel(color: Colors.grey[900], child: index,
            );
          }
  },

        ),
      );
  }
}
