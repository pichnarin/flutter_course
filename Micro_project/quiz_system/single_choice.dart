import 'question.dart';

class SingleChoice extends Question {
  String correctAnswer;

  SingleChoice({required super.question, required super.options, required this.correctAnswer});
}