import 'dart:convert';
import 'package:damdleaders_flutter/Models/Auth/LoginResponse.dart';
import 'package:damdleaders_flutter/Models/Auth/RegisterResponse.dart';
import 'package:http/http.dart' as http;

class AuthController {
  // URL de l'API backend pour la connexion et l'enregistrement
  final String loginUrl = "http://192.168.1.129:3000/auth/login";
  final String registerUrl = "http://192.168.1.129:3000/auth/signup"; 

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
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Vérification du code de réponse
      if (response.statusCode == 200) { // Vérification pour le code 200 (succès de la connexion)
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

  /// Fonction pour effectuer un enregistrement
  Future<RegisterResponse?> register(String email, String password, String name, String lastname, String phoneNumber, String codePostal, String website) async {
    try {
      // Corps de la requête
      Map<String, String> body = {
        'email': email,
        'password': password,
        'name': name,
        'lastname': lastname,
        'phoneNumber': phoneNumber,
        'codePostal': codePostal,
        'website': website,
        // Tu peux ajouter d'autres champs nécessaires à l'inscription ici
      };

      // Envoi de la requête POST pour l'enregistrement
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Vérification du code de réponse
      if (response.statusCode == 201) { // Vérification pour le code 201 (création réussie)
        // Décodage de la réponse en JSON
        final jsonResponse = jsonDecode(response.body);
        // Conversion de la réponse JSON en objet RegisterResponse
        return RegisterResponse.fromJson(jsonResponse);
      } else {
        print('Erreur lors de l\'enregistrement: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception lors de l\'enregistrement: $e');
      return null;
    }
  }
}
