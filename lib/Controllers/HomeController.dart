
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Models/Post.dart';

class HomeController {
  final String apiUrl = "http://192.168.1.162:3000/post"; // URL de l'API backend

  // Méthode pour récupérer tous les posts
    Future<List<Post>> fetchVideos() async {
      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          // Retourner une liste d'objets Post
          print("-----------------------------------------------------");
          print(data);
          print("-----------------------------------------------------");
          return data.map((json) => Post.fromJson(json)).toList();
        } else {
          throw Exception("Failed to load posts");
        }
      } catch (e) {
        throw Exception("Error fetching videos: $e");
      }
    }

    // Méthode pour récupérer les posts d'un utilisateur spécifique
  Future<List<Post>> fetchMyPosts(String userId) async {
    final String apiUrl1 = "$apiUrl/user/674cabd54603d2eeb31c56e3"; // API URL with user ID Statiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiique

    try {
      final response = await http.get(Uri.parse(apiUrl1));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
          print("------------------------data-----------------------------");
          print(data);
          print("-----------------------------------------------------");
          print("----------------------response-------------------------------");
          print(response);
          print("-----------------------------------------------------");
        // Retourner une liste d'objets Post
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load my posts");
      }
    } catch (e) {
      throw Exception("Error fetching my posts: $e");
    }
  }


  // Method to update user profile
  Future<Map<String, dynamic>> updateUserProfile(
      String userId, Map<String, dynamic> profileData, File? photo) async {
    final String updateProfileUrl = "http://192.168.1.162:3000/user/674cabd54603d2eeb31c56e3";

    try {
      var request = http.MultipartRequest('PUT', Uri.parse(updateProfileUrl));

      // Add JSON data as fields
      profileData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Add photo file if present
      if (photo != null) {
        request.files.add(await http.MultipartFile.fromPath('photoUrl', photo.path));
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        print("Profile updated successfully:");
        print(data);

        return data; // Return updated user data
      } else {
        throw Exception("Failed to update profile: ${response.statusCode}");
      }
    } catch (e) {
      print("tneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeket:");
      print("Error updating profile: $e");
      throw Exception("Error updating profile: $e");
              

    }
  }


}


