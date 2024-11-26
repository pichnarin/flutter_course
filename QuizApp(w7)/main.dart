import 'model/quiz.dart';
import 'model/submission.dart';

void main() {
  // Create questions
  Question question1 = Question(
    question: 'What is 2 + 2?',
    options: ['3', '4', '5'],
    correctAnswer: ['4'],
  );

  Question question2 = Question(
    question: 'What is the capital of France?',
    options: ['Paris', 'London', 'Berlin'],
    correctAnswer: ['Paris'],
  );

  Question question3 = Question(
    question: 'Select all prime numbers',
    options: ['2', '3', '4', '5'],
    correctAnswer: ['2', '3', '5'],
  );

  // Create submissions
  Submission submission1 = Submission(qId: question1.qId, answer: ['4']);
  Submission submission2 = Submission(qId: question2.qId, answer: ['Paris']);
  Submission submission3 = Submission(qId: question3.qId, answer: ['2', '3']);

  // Create a quiz
  Quiz quiz = Quiz(
    questions: [question1, question2, question3],
    submissions: {
      'user1': [submission1, submission2, submission3],
    },
  );

  // Evaluate the quiz
  int score = quiz.evaluate();
  print('Score: $score');  // Output: Score: 3
}