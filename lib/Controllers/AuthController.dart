// import 'dart:convert';
// import 'package:damdleaders_flutter/Models/Auth/LoginResponse.dart';
// import 'package:damdleaders_flutter/Models/Auth/RegisterResponse.dart';
// import 'package:http/http.dart' as http;
// import '../Models/Auth/LoginResponse.dart';

// class AuthController {
//   // URL de l'API backend pour la connexion et l'enregistrement
//   final String loginUrl = "http://192.168.75.1:3000/auth/login";
//   final String registerUrl = "http://192.168.75.1:3000/auth/signup";
//   final String api = "http://192.168.75.1:3000/auth";

//   /// Fonction pour effectuer une connexion
//   login(String email, String password) async {
//     try {
//       // Corps de la requête
//       Map<String, String> body = {
//         'email': email,
//         'password': password,
//       };

//       // Envoi de la requête POST
//       final response = await http.post(
//         Uri.parse(loginUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(body),
//       );
//       print("we are in this step");

//       // Vérification du code de réponse
//       if (response.statusCode == 201) {  // Vérification pour le code 201 (création réussie)
//         // Décodage de la réponse en JSON

//         final jsonResponse = jsonDecode(response.body);
//         print("we are in this step11yg(yy ${jsonResponse}");
//         // Conversion de la réponse JSON en objet LoginResponse
//         return LoginResponse.fromJson(jsonResponse);

//       } else {
//         print('Erreur lors de la connexion: ${response.statusCode} - ${response.body}');
//         return response;
//       }
//     } catch (e) {
//       print('Exception lors de la connexion: $e');
//       return null;
//     }
//   }

//   /// Fonction pour effectuer un enregistrement
//   Future<RegisterResponse?> register(String email, String password, String name, String lastname, String phoneNumber, String codePostal, String website) async {
//     try {
//       // Corps de la requête
//       Map<String, String> body = {
//         'email': email,
//         'password': password,
//         'name': name,
//         'lastname': lastname,
//         'phoneNumber': phoneNumber,
//         'codePostal': codePostal,
//         'website': website,
//         // Tu peux ajouter d'autres champs nécessaires à l'inscription ici
//       };

//       // Envoi de la requête POST pour l'enregistrement
//       final response = await http.post(
//         Uri.parse(registerUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(body),
//       );

//       // Vérification du code de réponse
//       if (response.statusCode == 201) { // Vérification pour le code 201 (création réussie)
//         // Décodage de la réponse en JSON
//         final jsonResponse = jsonDecode(response.body);
//         // Conversion de la réponse JSON en objet RegisterResponse
//         return RegisterResponse.fromJson(jsonResponse);
//       } else {
//         print('Erreur lors de l\'enregistrement: ${response.statusCode} - ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print('Exception lors de l\'enregistrement: $e');
//       return null;
//     }
//   }
//   Future<Map<String, dynamic>> resetPassword(String resetToken, String newPassword) async {
//     final response = await http.put(
//       Uri.parse("$api/reset-password"),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'resetToken': resetToken,
//         'newPassword': newPassword,
//       }),
//     );

//     if (response.statusCode >= 200 && response.statusCode <= 299) {
//       // Si la requête réussit, retournez les données de la réponse
//       return json.decode(response.body);
//     } else {
//       // Si la requête échoue, lancez une exception
//       throw Exception('Failed to reset password');
//     }

//   }
// }


import 'dart:convert';
import 'package:damdleaders_flutter/Models/Auth/LoginResponse.dart';
import 'package:damdleaders_flutter/Models/Auth/RegisterResponse.dart';
import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/Auth/LoginResponse.dart';

class AuthController {
  // URL de l'API backend pour la connexion et l'enregistrement
  final String loginUrl = "http://192.168.0.101:3000/auth/login";
  final String registerUrl = "http://192.168.0.101:3000/auth/signup";
  final String api = "http://192.168.0.101:3000/auth";

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
      print("we are in this step");

      // Vérification du code de réponse
      if (response.statusCode == 201) {
        // Vérification pour le code 201 (création réussie)
        // Décodage de la réponse en JSON
        final jsonResponse = jsonDecode(response.body);
        print("we are in this step11yg(yy ${jsonResponse}");
        final loginResponse = LoginResponse.fromJson(jsonResponse);

        // Sauvegarder les informations dans UserPreference
        await UserPreference.setEmail(email);
        await UserPreference.setName(loginResponse.name);
        await UserPreference.setLastName(loginResponse.lastname);
        await UserPreference.setDomaine(loginResponse.domaine ?? '');
        print(
            "Utilisateur connecté : ${loginResponse.name}, ${loginResponse.lastname}, ${loginResponse.domaine}");
        return loginResponse;
      } else {
        print(
            'Erreur lors de la connexion: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception lors de la connexion: $e');
      return null;
    }
  }

  /// Fonction pour effectuer un enregistrement
  Future<RegisterResponse?> register(
      String email,
      String password,
      String name,
      String lastname,
      String phoneNumber,
      String codePostal,
      String website) async {
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
      if (response.statusCode == 201) {
        // Vérification pour le code 201 (création réussie)
        // Décodage de la réponse en JSON
        final jsonResponse = jsonDecode(response.body);
        // Conversion de la réponse JSON en objet RegisterResponse
        return RegisterResponse.fromJson(jsonResponse);
      } else {
        print(
            'Erreur lors de l\'enregistrement: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception lors de l\'enregistrement: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      String resetToken, String newPassword) async {
    final response = await http.put(
      Uri.parse("$api/reset-password"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'resetToken': resetToken,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      // Si la requête réussit, retournez les données de la réponse
      return json.decode(response.body);
    } else {
      // Si la requête échoue, lancez une exception
      throw Exception('Failed to reset password');
    }
  }

  Future<String?> getUserName() async {
    return await UserPreference.getName();
  }

  Future<String?> getUserLastName() async {
    return await UserPreference.getLastName();
  }

  Future<String?> getUserDomaine() async {
    return await UserPreference.getDomaine();
  }
}