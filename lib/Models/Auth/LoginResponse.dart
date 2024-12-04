import 'dart:ffi';

import '../Post.dart';

class LoginResponse {
  String accessToken;
  String refreshToken;
  String name;
  String lastname;
  String email;
  String domaine;
  String phoneNumber;
  String codePostal;
  String website;
  String photoUrl;
  String userId;
  List<Post> posts;
  int statusCode;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.name,
    required this.lastname,
    required this.email,
    required this.domaine,
    required this.phoneNumber,
    required this.codePostal,
    required this.website,
    required this.photoUrl,
    required this.userId,
    required this.posts,
    required this.statusCode,
  });

  /// Factory constructor to create a LoginResponse object from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      name: json['name'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      domaine: json['domaine'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      codePostal: json['codePostal'] ?? '',
      website: json['website'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      userId: json['userId'] ?? '',
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      statusCode: json['statusCode'] != null ? json['statusCode'] as int : 200,  // Gestion de la nullité ici
    );
  }


  /// Method to serialize a LoginResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'name': name,
      'lastname': lastname,
      'email': email,
      'domaine': domaine,
      'phoneNumber': phoneNumber,
      'codePostal': codePostal,
      'website': website,
      'photoUrl': photoUrl,
      'statusCode': statusCode,
      'userId': userId,
      'posts': posts.map((e) => e.toJson()).toList(),
    };
  }
}
