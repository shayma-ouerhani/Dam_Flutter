// import 'dart:convert';
// import 'package:http/http.dart' as http;

// // Define a model class for Stats
// class Stats {
//   final String postName;
//   final int postulations;

//   Stats({required this.postName, required this.postulations});

//   // Factory method to create a Stats instance from JSON
//   factory Stats.fromJson(Map<String, dynamic> json) {
//     return Stats(
//       postName: json['postName'],
//       postulations: json['postulations'],
//     );
//   }
// }

// // Fetching stats for a user
// Future<List<Stats>> fetchApplicationsPerPost(String userId) async {
//   final String apiUrl = "http://localhost:3000/postuler/stats/$userId"; // Corrected endpoint

//   try {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);

//       // Parse JSON into a list of Stats objects
//       return data.map((jsonItem) => Stats.fromJson(jsonItem)).toList();
//     } else {
//       throw Exception("Failed to load Stats: ${response.statusCode} - ${response.body}");
//     }
//   } catch (e) {
//     throw Exception("Error fetching stats: $e");
//   }
// }

// Model Class for Stats
class Stats {
  final String postName;
  final int postulations;

  Stats({required this.postName, required this.postulations});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      postName: json['postName'],
      postulations: json['postulations'],
    );
  }
}