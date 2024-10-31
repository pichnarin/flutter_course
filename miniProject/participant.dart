class Participant {
  final String firstName;
  final String lastName;
  Map<String, dynamic> results;  // Map to store participant's answers
  int score;

  // Constructor with required parameters and default values
  Participant({
    required this.firstName,
    required this.lastName,
    Map<String, dynamic>? results,
    int score = 0,
  })  : results = results ?? {}, // Initialize results with an empty map if null
        score = score; // Initialize score

  @override
  String toString() {
    return '$firstName $lastName - Score: $score';
  }
}
