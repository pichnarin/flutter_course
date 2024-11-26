// quiz.dart
import 'package:flutter_leasson/QuizApp(w7)/model/submission.dart';
import 'package:uuid/uuid.dart';

class Quiz {
  final List<Question> _questions;  // Made private
  final Map<String, List<Submission>> _submissions;  // Made private

  Quiz({required List<Question> questions, required Map<String, List<Submission>> submissions})
      : _questions = questions,
        _submissions = submissions;

  List<Question> get questions => _questions;  // Getter for questions
  Map<String, List<Submission>> get submissions => _submissions;  // Getter for submissions

  void addQuestion(Question question) {
    _questions.add(question);
  }

  void removeQuestion(Question question) {
    _questions.remove(question);
  }

  // Get answers for all questions
  List<String> getAnswers() {
    return _questions.map((question) => question.correctAnswer.toString()).toList();
  }

  // Evaluate answers and calculate the score
  int evaluate() {
    int score = 0;

    // Iterate over each submission entry (user)
    for (var submissionEntry in _submissions.entries) {
      // Iterate over each question
      for (var question in _questions) {
        // Get selected answers for the current question (for this particular user)
        final selectedAnswers = submissionEntry.value
            .where((submission) => submission.qId == question.qId)
            .expand((submission) => submission.answer)
            .toList();

        // Ensure selectedAnswers is not empty and check if the answer is correct
        if (selectedAnswers.isNotEmpty && question.checkAnswer(selectedAnswers)) {
          score++;
        }
      }
    }
    return score;
  }
}

class Question {
  final String qId;
  final String question;
  final List<String> options;
  final List<String> correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    String? qId,
  }) : qId = qId ?? const Uuid().v4();  // Initialize qId only once

  // Check if the selected answer is correct or not
  bool checkAnswer(List<String> selectedAnswer) {
    return selectedAnswer.toSet().containsAll(correctAnswer.toSet()) &&
        correctAnswer.toSet().containsAll(selectedAnswer.toSet());
  }
}