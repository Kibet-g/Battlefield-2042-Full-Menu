import 'dart:ui';

import 'package:tetris_game/board.dart';

import 'values.dart';
//check for valid position
bool positionIsValid(int position){
  //get the row and collumn of the current position
  int row=(position/rowLength).floor();
  int col= position%rowLength;
  //Now if the position is taken, return false
  if (row<0 || col<0 || gameBoard[row][col] !=null){
    return false;
  }
  //else we say that if position is valid so return true
  else{
    return true;
  }

}
bool piecePositionIsValid(List<int> piecePosition){
  bool firstColOccupied = false;
  bool lastColOccupied = false;
  for (int pos in piecePosition){
    //return false if any position
    if(!positionIsValid(pos)){
      return false;
    }
    //get the col of position
    int col=pos%rowLength;
    //check if the first or last collumn is occupied
    if (col==0){
      firstColOccupied= true;
    }
    if (col== rowLength -1){
      lastColOccupied= true;
    }
  }
  //if there is a piece in the first and last col and last col it will automatically pass through the wall
  return !(firstColOccupied && lastColOccupied );

}
class Piece {
  // The type of the tetris piece
  Tetromino type;

  Piece({required this.type});
  List<int> position = [];

  //COLOR OF THE TETRIS PIECE
  Color get color {
    return tetrominoColors[type] ??
        const Color(
            0xFFFFFFFF); //Always allocate white color if no color us found

  }
  // LET US NOW GENERATE THE INTEGERS
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];

        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];

      default:
    }
  }
  //Our moving piece method
void movePiece(Direction direction){
    switch(direction){
      case Direction.down:
        for(int i=0; i<position.length; i++){
          position[i] += rowLength;
        }

          break;
        //
      case Direction.left:
        for(int i=0; i<position.length; i++){
          position[i] -= 1;
        }

        break;
        //
      case Direction.right:
        for(int i=0; i<position.length; i++){
          position[i] += 1;
        }

        break;
        default:
    }
}
//Rotate piece
int rotationState = 1;
  void rotatePiece()
  {
    //new position
    List<int> newPosition = [];
    //rotate rge piece based on its type
    switch(type){
      case Tetromino.L:
        switch(rotationState){
          case 0:

            newPosition= [
              position[1]-rowLength,
              position[1],
              position[1]+rowLength,
              position[1]+rowLength+1,
            ];
            //check if position is valid
            if (piecePositionIsValid(newPosition)){
              //now lets update the position
              position=newPosition;
              //update rotation state
              rotationState= (rotationState+1)%4;
            }

        break;
          case 1:
            newPosition= [
              position[1]-1,
              position[1],
              position[1]+1,
              position[1]+rowLength-1,
            ];
            //check if position is valid
            if (piecePositionIsValid(newPosition)){
              //now lets update the position
              position=newPosition;
              //update rotation state
              rotationState= (rotationState+1)%4;
            }
            break;
          case 2:
            newPosition= [
              position[1]+rowLength,
              position[1],
              position[1]-rowLength,
              position[1]-rowLength-1,
            ];
            //check if position is valid
            if (piecePositionIsValid(newPosition)){
              //now lets update the position
              position=newPosition;
              //update rotation state
              rotationState= (rotationState+1)%4;
            }
            break;
          case 3:
            newPosition= [
              position[1]-rowLength+1,
              position[1],
              position[1]+1,
              position[1]-1,
            ];
            //check if position is valid
            if (piecePositionIsValid(newPosition)){
              //now lets update the position
              position=newPosition;
              //update rotation state
              rotationState= (rotationState+1)%4;
            }
            break;
        }

        break;
        default:
    }

  }
}
