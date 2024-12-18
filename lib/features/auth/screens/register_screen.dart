import 'dart:convert';
import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';
import 'package:damdleaders_flutter/shared/login_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    const String apiUrl = "http://192.168.1.7:3000/auth/signup";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": firstName,
          "lastname": lastName,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        print("User registered successfully");
      } else {
        final responseBody = jsonDecode(response.body);
        print("Registration failed: ${responseBody['message']}");
      }
    } catch (error) {
      print("Error registering user: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Encapsuler le formulaire
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Create An Account',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF130160),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Let\'s log in. Apply to jobs!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                LoginTextField(
                  label: "First Name",
                  controller: firstNameController,
                  icon: Icons.person,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                LoginTextField(
                  label: "Last Name",
                  controller: lastNameController,
                  icon: Icons.person,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                LoginTextField(
                  label: "E-mail",
                  controller: emailController,
                  icon: Icons.email,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                LoginTextField(
                  label: "Password",
                  controller: passwordController,
                  icon: Icons.lock,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                LoginTextField(
                  label: "Confirm Password",
                  controller: confirmPasswordController,
                  icon: Icons.lock,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await registerUser(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form Submitted Successfully!'),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registration Failed: $error'),
                            ),
                          );
                        }
                      } else {
                        // Afficher les erreurs
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill out the form'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF130160),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 135,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Logique pour la connexion avec Google
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6CDFE),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 75,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xFF130160),
                    ),
                    label: const Text(
                      'Sign up with Google',
                      style: TextStyle(
                        color: Color(0xFF130160),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You don't have an account yet?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF9228),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
