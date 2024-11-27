import 'package:flutter/material.dart';
import 'package:flutter_leasson/QuizApp(w7)/widgets/app_button.dart';
import 'home_screen.dart';
import '../model/quiz.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final Quiz quiz;
  final Map<String, List<String>> userAnswers;

  const ResultScreen({super.key, required this.score, required this.quiz, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Your Score',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Text(
                  '$score',
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton(
                      label: 'Restart Quiz',
                      icon: Icons.refresh,
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20,),

          Expanded(

            child: ListView.builder(
              itemCount: quiz.questions.length,
              itemBuilder: (context, index) {
                final question = quiz.questions[index];
                final userAnswer = userAnswers[question.qId] ?? [];
                final correctAnswer = question.correctAnswer;

                return ListTile(
                  title: Text(question.question),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Answer: ${userAnswer.join(', ')}'),
                      Text('Correct Answer: ${correctAnswer.join(', ')}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}