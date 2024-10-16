
class Point{

  final double x;
  final double y;

  const Point(this.x, this.y);

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }
}

class Shape{

  final Point leftBottom;
  final double width;
  final double height;
  final String? backgroundColor; //optional background color

  Shape({
    required this.width,
    required this.height,
    required this.leftBottom,
    this.backgroundColor, //optional
  });

  //getter for the right top point
  Point get rightTop {
    double x = leftBottom.x + width;
    double y = leftBottom.y + height;
    return Point(x, y);
  }



  @override
  String toString() {
    return 'Shape{leftBottom: $leftBottom, width: $width, height: $height, backgroundColor: $backgroundColor}';
  }

}

void main() {

  // Shape with no background color
  var shape1 = Shape(
    width: 10,
    height: 5,
    leftBottom: const Point(0, 0),
  );
  print(shape1);
  print('Right-top point: ${shape1.rightTop}');

  // Shape with a background color
  var shape2 = Shape(
    width: 3,
    height: 4,
    leftBottom: const Point(5, 5),
    backgroundColor: 'blue',
  );

  print(shape2);
  print('Right-top point: ${shape2.rightTop}');

  // Shape with zero width and height
  var shape3 = Shape(
    width: 0,
    height: 0,
    leftBottom: const Point(2, 2),
  );
  print(shape3);
  print('Right-top point: ${shape3.rightTop}');
}