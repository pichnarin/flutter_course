

void main() {
  // List of student scores
  List<int> scores = [45, 67, 82, 49, 51, 78, 92, 30];

  // You code
  int passScore = 50;

  List<int> passScoreList = scores.where((scores) => scores >= passScore).toList();

  //result

  print(passScoreList);
}

