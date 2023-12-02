import 'values.dart';

class Piece {
  // The type of the tetris piece
  Tetronim type;

  Piece({required this.type});
  List<int> position = [];

  // LET US NOW GENERATE THE INTEGERS
  void initializePiece() {
    switch (type) {
      case Tetronim.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
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
      case Direction.down:
        for(int i=0; i<position.length; i++){
          position[i] += rowLength;
        }

        break;
        //
      case Direction.left:
        for(int i=0; i<position.length; i++){
          position[i] -= rowLength;
        }

        break;
        //
      case Direction.right:
        for(int i=0; i<position.length; i++){
          position[i] += 1; rowLength;
        }

        break;
  default:
    }
}
}
