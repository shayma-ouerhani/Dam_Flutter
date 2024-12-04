
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Post.dart';

class HomeController {
  final String apiUrl = "http://192.168.1.129:3000/post"; // URL de l'API backend

  // Méthode pour récupérer tous les posts
    Future<List<Post>> fetchVideos() async {
      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          // Retourner une liste d'objets Post
          return data.map((json) => Post.fromJson(json)).toList();
        } else {
          throw Exception("Failed to load posts");
        }
      } catch (e) {
        throw Exception("Error fetching videos: $e");
      }
    }


}
