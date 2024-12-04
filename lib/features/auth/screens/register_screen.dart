import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';
import 'package:damdleaders_flutter/shared/login_text_fields.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            // Encapsuler le formulaire
            key: _formKey,
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Formulaire valide : continuer l'inscription
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Form Submitted Successfully!')),
                        );
                      } else {
                        // Afficher les erreurs
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill out the form')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF130160),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 135),
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
                          vertical: 10, horizontal: 75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 0.0),
                      child: Icon(
                        Icons.email_outlined,
                        color: Color(0xFF130160),
                      ),
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
                              builder: (context) => LoginScreen()),
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
