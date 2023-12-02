import 'package:flutter/material.dart';

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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowLength,
        ),
        // This is the slivergridelegatewithCrossAxisCount
        itemBuilder: (context, index) => Center(
          child: Text(
            index.toString(),
            style: TextStyle(backgroundColor: Colors.white),
          ),
        ),
      ),
    );
  }
}
