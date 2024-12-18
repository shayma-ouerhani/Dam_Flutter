// class Stats {
//   final String postName;
//   final int postulations;

//   Stats({required this.postName, required this.postulations});

//   factory Stats.fromJson(Map<String, dynamic> json) {
//     return Stats(
//       postName: json['postName'],
//       postulations: json['postulations'],
//     );
//   }
// }
class Stats {
  final String postName;
  final int postulations;
  final List<int> scores;

  Stats({
    required this.postName,
    required this.postulations,
    required this.scores,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      postName: json['postName'],
      postulations: json['postulations'],
      scores: List<int>.from(json['scores'] ?? []), // Parse scores safely
    );
  }
}
