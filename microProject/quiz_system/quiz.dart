import 'multiple__choice.dart';
import 'participant.dart';
import 'question.dart';
import 'single_choice.dart';

// Class to represent a quiz that contains questions and participants and methods to evaluate and display results
class Quiz {
 final List<Question> questions = [];
 final List<Participant> participants = [];

  // Method to add questions
  void addQuestion(Question question) {
    questions.add(question);
  }

  // Method to add participants
  void addParticipant(Participant participant) {
    participants.add(participant);
  }

  // Method to check and display correct answers
  void displayCorrectAnswers() {
    for (var question in questions) {
      if (question is SingleChoice) {
        print('Correct Answer: ${(question).correctAnswer}');
      } else if (question is MultipleChoice) {
        print('Correct Answers: ${(question).correctAnswers.join(', ')}');
      }
    }
  }

  // Method to evaluate and update scores based on participant answers
  void evaluateAnswers() {
    for (var participant in participants) {
      for (var question in questions) {
        var participantAnswer = participant.results[question.question];
        if (question is SingleChoice) {
          if (participantAnswer == question.correctAnswer) {
            participant.score++;
          }
        } else if (question is MultipleChoice) {
          if (participantAnswer is List) {
            // Check if all correct answers are included in the participant's answers
            if (participantAnswer.toSet().containsAll(question.correctAnswers)) {
              participant.score++;
            }
          }
        }
      }
    }
  }


  // Method to display results
  void displayResults() {
    for (var participant in participants) {
      print('${participant.firstName} ${participant.lastName} Results:');
      print('Score: ${participant.score}');
      for (var questionTitle in participant.results.keys) {
        print('$questionTitle: ${participant.results[questionTitle]}');
      }
    }
  }


}

void main() {
  final quiz = Quiz();

  // Adding questions
  quiz.addQuestion(SingleChoice(question: 'What is the capital of France?', options: ['Paris', 'London', 'Berlin'], correctAnswer: 'Paris'));
  quiz.addQuestion(MultipleChoice(question: 'Which of the following are fruits?', options: ['Apple', 'Carrot', 'Banana'], correctAnswers: ['Apple', 'Banana']));

  // Adding participants
  final participant1 = Participant(firstName: 'John', lastName: 'Doe');
  final participant2 = Participant(firstName: 'Jane', lastName: 'Smith');

  quiz.addParticipant(participant1);
  quiz.addParticipant(participant2);

  // Display results
  quiz.displayResults();

  // Evaluate answers
  participant1.results['What is the capital of France?'] = 'Paris';
  participant1.results['Which of the following are fruits?'] = ['Apple', 'Banana'];

  participant2.results['What is the capital of France?'] = 'London';
  participant2.results['Which of the following are fruits?'] = ['Apple', 'Carrot'];

  quiz.evaluateAnswers();

  // Display results after evaluation
  quiz.displayResults();
}