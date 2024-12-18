class Survey {
  final List<String> questions;

  Survey({required this.questions});

factory Survey.fromJson(dynamic json) {
  if (json is List) {
    return Survey(questions: List<String>.from(json));
  } else if (json is Map<String, dynamic>) {
    return Survey(questions: List<String>.from(json['questions'] ?? []));
  } else {
    throw Exception("Unexpected JSON format");
  }
}

}