// LET'S CREATE OUR GRID DIMENSIONS
import 'dart:ui';

import 'package:flutter/material.dart';

int rowLength = 10;
int collength = 15;

enum Direction{
  left,
  right,
  down,
}
enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,

}
//VARIOUS TETROSHAPES FOR OUR TETRIS GAME
const Map<Tetromino, Color>tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500), //orange color
  Tetromino.J: Color.fromARGB(255,0,102,255),//blue color
  Tetromino.I: Color.fromARGB(255,242,0,255),//pink color
  Tetromino.O: Color(0xFFFFFF00),//yellow color
  Tetromino.S: Color(0xFF008000),//green color
  Tetromino.Z:  Color(0xFFFF0000),//Red color
  Tetromino.T:  Color.fromARGB(255, 144, 0,255 ),//Purple color
};