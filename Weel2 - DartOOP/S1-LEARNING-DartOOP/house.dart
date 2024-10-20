enum Place{right, left, middle}

class House{

  final String _address;
  final int _stair;

  House(this._address, this._stair);

  //Object list
  List<Tree> trees = [];

  List<Window> windows = [];

  List<Door> doors = [];

  List<Roof> roofs = [];

  List<Chimney> chimneys = [];

  //method

  void addTree(Tree tree){
    trees.add(tree);
  }

  void addWindow(Window window){
    windows.add(window);
  }

  void addDoor(Door door){
    doors.add(door);
  }

  void addRoof(Roof roof){
    roofs.add(roof);
  }

  void addChimney(Chimney chimney){
    chimneys.add(chimney);
  }

  int get stair => _stair;

  String get address => _address;

  @override
  String toString() {
    return 'House {\n'
        '  Address: $_address,\n'
        '  Stair count: $_stair,\n'
        '  Trees: ${trees.join('\n          ')},\n'
        '  Windows: ${windows.join('\n           ')},\n'
        '  Doors: ${doors.join('\n          ')},\n'
        '  Roofs: ${roofs.join('\n          ')},\n'
        '  Chimneys: ${chimneys.join('\n            ')}\n'
        '}';
  }
}


class Chimney {

  final String _type;
  final double _height;
  final double _width;
  final Place _place;

  Chimney(this._height, this._type, this._width, this._place);

  Place get place => _place;

  double get width => _width;

  double get height => _height;

  String get type => _type;

  @override
  String toString() {
    return 'Chimney{'
        '_type: $_type,'
        ' _height: $_height,'
        ' _width: $_width,'
        ' _place: $_place}';
  }
}

class Roof {

  final String _type;
  final String _color;
  final double _width;
  final double _height;

  Roof(this._type, this._color, this._width, this._height);

  double get height => _height;

  double get width => _width;

  String get color => _color;

  String get type => _type;

  @override
  String toString() {
    return 'Roof{'
        '_type: $_type,'
        ' _color: $_color, '
        '_width: $_width, '
        '_height: $_height}';
  }
}

class Door {

  final String _type;
  final double _height;
  final double _width;
  final String _color;
  final Place _place;
  final int _stair;

  Door(this._type, this._height, this._width, this._color, this._place, this._stair);

  Place get place => _place;

  String get color => _color;

  double get width => _width;

  double get height => _height;

  String get type => _type;

  int get stair => _stair;

  @override
  String toString() {
    return 'Door{'
        '_type: $_type,'
        ' _height: $_height, '
        '_width: $_width, '
        '_color: $_color, '
        '_place: $_place,'
        ' _stair: $_stair}';
  }
}

class Window {

  final String _type;
  final double _width;
  final double _height;
  final int _amount;
  final Place _place;
  final int _stair;

  Window(this._type, this._width, this._height, this._amount, this._place, this._stair);

  Place get place => _place;

  int get amount => _amount;

  double get height => _height;

  double get width => _width;

  String get type => _type;

  int get stair => _stair;

  @override
  String toString() {
    return 'Window{'
        '_type: $_type,'
        ' _width: $_width,'
        ' _height: $_height,'
        ' _amount: $_amount,'
        ' _place: $_place,'
        ' _stair: $_stair}';
  }
}

class Tree {

  final String _type;
  final double _height;
  final int _amount;

  Tree(this._type, this._height, this._amount);

  int get amount => _amount;

  double get height => _height;

  String get type => _type;

  @override
  String toString() {
    return 'Tree{'
        '_type: $_type,'
        ' _height: $_height, '
        '_amount: $_amount}';
  }
}

void main() {
  // Create a house
  House house = House("OnTheStreet168", 2);

  // Add a door
  Door door = Door("Wooden", 2.0, 1.0, "Brown", Place.middle, 1);
  Door door1 = Door("Wooden", 2.0, 1.0, "Brown", Place.right, 2);

  house.addDoor(door);
  house.addDoor(door1);

  // Add a window
  Window window = Window("Glass", 1.2, 1.0, 2, Place.left, 1);
  Window window1 = Window("Glass", 1.2, 1.0, 2, Place.right, 2);

  house.addWindow(window);
  house.addWindow(window1);

  // Add a tree
  Tree tree = Tree("Oak", 5.0, 3);
  house.addTree(tree);

  // Add a roof
  Roof roof = Roof("Gable", "Red", 10.0, 5.0);
  house.addRoof(roof);

  // Add a chimney
  Chimney chimney = Chimney(3.0, "Brick", 1.0, Place.right);
  house.addChimney(chimney);

  // Print details about the house
  print(house.toString());


}

