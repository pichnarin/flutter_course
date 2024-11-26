import 'package:flutter/material.dart';
import 'package:flutter_leasson/QuizApp(w7)/widgets/app_button.dart';
import 'package:flutter_leasson/QuizApp(w7)/widgets/option_tile.dart';
import '../model/quiz.dart';
import '../model/submission.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  late Quiz quiz;
  int currentQuestionIndex = 0;
  Map<String, List<String>> userAnswers = {};

  @override
  void initState() {
    super.initState();
    // Initialize the quiz with questions
    quiz = Quiz(
      questions: [
        Question(
          question: 'What is 2 + 2?',
          options: ['3', '4', '5'],
          correctAnswer: ['4'],
        ),
        Question(
          question: 'What is the capital of France?',
          options: ['Paris', 'London', 'Berlin'],
          correctAnswer: ['Paris'],
        ),
        Question(
          question: 'Select all prime numbers',
          options: ['2', '3', '4', '5'],
          correctAnswer: ['2', '3', '5'],
        ),
      ],
      submissions: {},
    );
  }

  // Check if all questions have been answered
  bool allQuestionsAnswered() {
    return userAnswers.length == quiz.questions.length;
  }

  // Proceed to the next question
  void nextQuestion() {
    if (currentQuestionIndex < quiz.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  // Go back to the previous question
  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  // Submit the quiz and evaluate the answers and validate the question is answered or not
  void submitQuiz() {
    if (allQuestionsAnswered()) {
      // Create submissions from user answers
      Map<String, List<Submission>> submissions = {
        'user1': userAnswers.entries.map((entry) {
          return Submission(qId: entry.key, answer: entry.value);
        }).toList(),
      };

      // Update the quiz with submissions
      quiz = Quiz(questions: quiz.questions, submissions: submissions);

      // Evaluate the quiz
      int score = quiz.evaluate();

      // Navigate to the result screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            quiz: quiz,
            userAnswers: userAnswers,
          ),
        ),
      );
    } else {
      // Find the first unanswered question
      for (int i = 0; i < quiz.questions.length; i++) {
        if (!userAnswers.containsKey(quiz.questions[i].qId)) {
          setState(() {
            currentQuestionIndex = i;
          });
          break;
        }
      }

      // Show alert if not all questions are answered
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incomplete Quiz'),
            content: const Text('Please answer all questions before submitting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //get the current question
    Question currentQuestion = quiz.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                currentQuestion.question,
                style: const TextStyle(fontSize: 24),
              ),

              // Display options
              ...currentQuestion.options.map((option) {
                bool isSelected =
                    userAnswers[currentQuestion.qId]?.contains(option) ?? false;
                return optionTile(
                  option: option,
                  value: isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        userAnswers
                            .putIfAbsent(currentQuestion.qId, () => [])
                            .add(option);
                      } else {
                        userAnswers[currentQuestion.qId]?.remove(option);
                      }
                    });
                  },
                );
              }),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (currentQuestionIndex > 0)
                    AppButton(
                      label: 'Previous',
                      icon: Icons.arrow_back,
                      onTap: previousQuestion,
                    ),
                  if (currentQuestionIndex < quiz.questions.length - 1)
                    AppButton(
                      label: 'Next',
                      icon: Icons.arrow_forward,
                      onTap: nextQuestion,
                    ),
                  AppButton(
                    label: 'Submit',
                    icon: Icons.check,
                    onTap: submitQuiz,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
