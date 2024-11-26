// submission.dart
class Submission {
  final String qId;
  final List<String> answer;

  Submission({required this.qId, required this.answer});

  // Add an answer
  void addAnswer(String newAnswer) {
    if (!answer.contains(newAnswer)) {
      answer.add(newAnswer);
    }
  }

  // Remove an answer
  void removeAnswer(String answerToRemove) {
    answer.remove(answerToRemove);
  }
}