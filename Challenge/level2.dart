class Point{
  final int _x;
  final int _y;

  Point(this._x, this._y);

  Point translate(int dx, int dy){
    return Point(_x+dx, _y+dy);
  }

  @override
  String toString() {
    return 'Point{x: $_x, y: $_y}';
  }


//getter because the variable declare as private
  int get y => _y;

  int get x => _x;
}

void main(){

  Point point1 = Point(8, 2);

  Point p2 = point1.translate(8, 2);

  print(p2.toString());


}