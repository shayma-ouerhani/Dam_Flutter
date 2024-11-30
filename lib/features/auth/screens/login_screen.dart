import 'package:damdleaders_flutter/features/auth/screens/register_screen.dart';
import 'package:damdleaders_flutter/shared/login_text_fields.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),

              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF130160),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Let's Login Apply to Jobs",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              // Champ Email
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
              const SizedBox(height: 24),
              // Bouton de connexion
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Logique pour la connexion
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF130160),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 162),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Lien pour l'inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You don't have an account yet?"),
                  TextButton(
                          onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RegisterScreen()), 
                  );
                },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF130160),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
