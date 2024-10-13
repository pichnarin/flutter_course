//TODO: Robot simulation
//NOTE: Robot moving in a grid have 4 directions (North, East, South, West)
//NOTE: Robot can move in 3 ways (Right, Left, Forward)
//NOTE:
//When the robot receive command to move (Right, Left) all you need to do is to find which direction that robot facing
//When the robot receive command to move (Forward) which mean the direction is still remind the same but the position [x,y] is changed
//When the robot facing North and its have to move forward the y position have to increase by 1
//When the robot facing South and its have to move forward the y position have to decrease by 1
//When the robot facing East and its have to move forward the x position have to increase by 1
//When the robot facing West and its have to move forward the x position have to decrease by 1

//Output: The robot's final direction
//Output: The robot's final [x,y] position

import 'dart:ffi';

//four direction
enum Direction { north, east, south, west }

class RobotMove {
  int x;

  int y;

  String instructions;

  Direction direction;

  RobotMove(this.instructions, this.direction, this.x, this.y);

  void goRight() {
    direction = Direction.values[(direction.index + 1) % 4];
  }

  void goLeft() {
    direction = Direction.values[(direction.index + 3) % 4];
  }

  void goForward() {
    //process each A command
    switch (direction) {
      case Direction.north:
        y += 1;
        break;
      case Direction.east:
        x += 1;
        break;
      case Direction.south:
        y -= 1;
        break;
      case Direction.west:
        x -= 1;
        break;
    }
  }

  String finalDirection() {
    //process each of the robot's instruction
    for (var instruction in instructions.split('')) {
      //use switch to process each command one by one
      switch (instruction) {
        case 'R':
          goRight();
          break;
        case 'L':
          goLeft();
          break;
        case 'A':
          goForward();
          break;
      }
    }
    return direction.toString();
  }

  void output() {
    print('The robot final direction is ${finalDirection().toString()}');
    print('The robot final position is [$x, $y]');
  }
}

void main() {
  //set the default direction for robot
  Direction direction = Direction.north;

  //default position
  int x = 7;
  int y = 3;

  RobotMove robotMove = RobotMove("RAALAL", direction, x, y);

  //the output
  robotMove.output();
}
