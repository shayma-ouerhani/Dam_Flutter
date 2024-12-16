class Survey {
  final List<String> questions;

  Survey({required this.questions});

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      questions: List<String>.from(json['questions'] ?? []), // Ensure it's a list of strings
    );
  }
}