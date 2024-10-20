//TODO: Manipulate final ans const

void main() {
  // 1 - iLike
  String iLike = 'I like pizza'; //CONST 	Because this variable never changes

  // 2 - toppings
  String toppings = 'with tomatoes';
  toppings += " and cheese";  //VAR	Because this variable can change its value

  // 3 - message
  String message = '$iLike $toppings'; //FINAL	Because this variable’s value it depends on other variable’s value
  print(message);

  // 4 - rbgColors
  List<String> rbgColors = ['red', 'blue', 'green'];//CONST	Because this list never changes
  print(rbgColors);

  // 5 - weekDays
  List<String> weekDays = ['monday', 'tuesday', 'wednesday']; //FINAL	Because this list can change
  weekDays.add('thursday');
  print(weekDays);

  // 6 - scores
  List<int> scores = [45,35,50]; //VAR 	Because this variable can change completely
  scores = [45,35,50, 78];
  print(scores);
}


