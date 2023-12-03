import 'values.dart';
class Piece {
  // The type of the tetris piece
  Tetromino type;

  Piece({required this.type});
  List<int> position = [];

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
