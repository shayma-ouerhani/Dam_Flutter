import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Auth/LoginResponse.dart';

class AuthController {
  final String apiUrl = "http://192.168.1.129:3000/auth/login"; // URL de l'API backend pour la connexion

  /// Fonction pour effectuer une connexion
  Future<LoginResponse?> login(String email, String password) async {
    try {
      // Corps de la requête
      Map<String, String> body = {
        'email': email,
        'password': password,
      };

      // Envoi de la requête POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Vérification du code de réponse
      if (response.statusCode == 201) {  // Vérification pour le code 201 (création réussie)
        // Décodage de la réponse en JSON
        final jsonResponse = jsonDecode(response.body);
        // Conversion de la réponse JSON en objet LoginResponse
        return LoginResponse.fromJson(jsonResponse);
      } else {
        print('Erreur lors de la connexion: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception lors de la connexion: $e');
      return null;
    }
  }
}
