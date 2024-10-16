class Point{
  int x;
  int y;

  Point(this.x, this.y);

  void translate(int dx, int dy){
    x += dx;
    y += dy;
  }

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }
}

void main(){

  Point point = Point(4, 2);

  point.translate(4, 2);

  print(point);
}