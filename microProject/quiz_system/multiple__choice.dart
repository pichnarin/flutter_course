import 'question.dart';

class MultipleChoice extends Question {
  List<String> correctAnswers;

  MultipleChoice({required super.question, required super.options, required this.correctAnswers});
}