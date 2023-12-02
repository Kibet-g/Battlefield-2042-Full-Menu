import 'package:flutter/material.dart';
import 'package:tetris_game/pixel.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // LET'S CREATE OUR GRID DIMENSIONS
  int rowLength = 10;
  int collength = 15;

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
        itemBuilder: (context, index) => Pixel(
            color:Colors.grey[900],
          child: index,
        ),

        ),
      );
  }
}
