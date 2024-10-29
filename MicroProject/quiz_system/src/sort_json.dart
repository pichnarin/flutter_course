import 'dart:io';
import 'dart:convert';

  // Get the file path
  final File file = File('src/project/quiz_system/data/questions.json');

  // Read and decode the JSON data
  final String jsonString = file.readAsStringSync().toLowerCase();
  final List<dynamic> jsonData = json.decode(jsonString);

  // Store questions, answers, and options
  final Map<String, Map<String, dynamic>> questionData = {
    for (var data in jsonData)
      data['question']: {
        'answer': data['answer'],
        'options': [data['a'], data['b'], data['c'], data['d']]
      }
  };


  // Store the user's answers
  final Map<String, String> userAnswers = {};

  // Store the user's score
  int score = 0;

  void main(){
    // Display the 5 questions and options
    for (var i = 0; i < 5; i++) {
      final question = questionData.keys.elementAt(i);
      final options = questionData[question]?['options'];

      print('Question ${i + 1}: $question');
      for (var j = 0; j < options.length; j++) {
        print('${String.fromCharCode(97 + j)}) ${options[j]}');
      }

      // Get the user's answer
      stdout.write('Enter your answer (a, b, c, d): ');
      final userAnswer = stdin.readLineSync();
      userAnswers[question] = userAnswer!;

      // Check if the answer is correct
      if (userAnswer == questionData[question]?['answer']) {
        score++;
      }
    }

    print('User answers: $userAnswers\n');
    print('User scores: $score\n');

  }



