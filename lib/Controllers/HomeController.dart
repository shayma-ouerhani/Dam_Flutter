import 'dart:convert';
import 'dart:io';
import 'package:damdleaders_flutter/Models/Stats.dart';
import 'package:damdleaders_flutter/Models/Survey.dart';
import 'package:http/http.dart' as http;
import '../Models/Post.dart';
import '../Models/Candidat.dart';
import 'package:http_parser/http_parser.dart';  // Import pour MediaType
import 'package:mime/mime.dart';  // Import pour lookupMimeType

class HomeController {
  final String apiUrl = "http://192.168.55.132:3000"; // URL de l'API backend

  // Méthode pour récupérer tous les posts
    Future<List<Post>> fetchVideos() async {
      // print("11111111111111111111111111111111111111111111111111111111111111111111");
      try {
        final response = await http.get(Uri.parse('$apiUrl/post'));

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

    final String apiUrl1 = "$apiUrl/post/user/674cabd54603d2eeb31c56e3"; // API URL with user ID Statiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiique

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

  // Méthode pour récupérer les candidats par ID de publication
  Future<List<Candidat>> fetchCandidatesByPost(String postId) async {
    final String apiUrl1 = "$apiUrl/postuler/usersByPost/$postId"; // L'URL de l'API backend

    try {
      final response = await http.get(Uri.parse(apiUrl1));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print("------------------------data-----------------------------");
        print(data);
        print("-----------------------------------------------------");

        // Retourner une liste d'objets Candidate
        return data.map((json) => Candidat.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load candidates");
      }
    } catch (e) {
      throw Exception("Error fetching candidates: $e");
    }
  }

// Method to fetch the survey based on the postId
Future<Survey> fetchSurveyByPost(String postId) async {
  final String apiUrl3 = "$apiUrl/post/survey/$postId"; // Replace with actual API URL

  try {
    final response = await http.get(Uri.parse(apiUrl3));

    if (response.statusCode == 200) {
  final List<dynamic> data = json.decode(response.body);
  return Survey(questions: List<String>.from(data));
    } else {
      throw Exception("Failed to load survey: ${response.body}");
    }
  } catch (e) {
    throw Exception("Error fetching survey: $e");
  }
}

// Fetching stats for a user
Future<List<Stats>> fetchApplicationsPerPost(String userId) async {
  final String apiUrl1 = "$apiUrl/postuler/stats/$userId"; // Corrected endpoint
  try {
    final response = await http.get(Uri.parse(apiUrl1));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Parse JSON into a list of Stats objects
      return data.map((jsonItem) => Stats.fromJson(jsonItem)).toList();
    } else {
      throw Exception("Failed to load Stats: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    throw Exception("Error fetching stats: $e");
  }
}
/************************** */

  // Method to update user profile
  Future<Map<String, dynamic>> updateUserProfile(
      String userId, Map<String, dynamic> profileData, File? photo) async {
    final String updateProfileUrl = "$apiUrl/user/67322ac07b0ef3c99e6a288c";

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
      print("teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeet:");
      print("Error updating profile: $e");
      throw Exception("Error updating profile: $e");
              

    }
  }

  // Fonction pour ajouter un post avec vidéo
  Future<void> addPost({
    required String title,
    required String description,
    required String user,
    required File videoFile,
  }) async {
    try {
      // Créer un objet MultipartRequest pour une requête POST
      var request = http.MultipartRequest('POST', Uri.parse("$apiUrl/post/android"));

      // Ajouter les champs texte du formulaire
      request.fields['title'] = title;
      request.fields['content'] = description;
      request.fields['user'] = user;

      // Ajouter le fichier vidéo
      var videoBytes = await videoFile.readAsBytes();
      var videoMimeType = lookupMimeType(videoFile.path); // Trouve le type MIME du fichier
      var videoFileName = videoFile.path.split('/').last; // Récupère le nom du fichier

      // Ajouter le fichier en tant que champ multipart
      request.files.add(http.MultipartFile.fromBytes(
        'file', // Nom du champ du formulaire pour la vidéo
        videoBytes,
        filename: videoFileName,
        contentType: MediaType.parse(videoMimeType ?? 'application/octet-stream'), // Type MIME par défaut si non trouvé
      ));

      // Envoyer la requête
      var response = await request.send();

      // Vérifier la réponse
      if (response.statusCode == 200) {
        print("Post ajouté avec succès");
      } else {
        print("Erreur lors de l'ajout du post : ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur : $e");
    }
  }


}



