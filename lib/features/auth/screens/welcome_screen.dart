import 'package:damdleaders_flutter/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Logo
            Column(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 250,
                ),
                SizedBox(height: 16),
              ],
            ),

            const Spacer(),
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft, // Alignement à gauche
                  child: Text(
                    'Find Your',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft, // Aligner à gauche
                  child: RichText(
                    textAlign:
                        TextAlign.left, // Alignement spécifique pour le texte
                    text: const TextSpan(
                      text: 'Dream Job ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                      children: [
                        TextSpan(
                          text: 'Here!',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            // Bouton flottant
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Naviguer vers RegisterScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                backgroundColor: Color(0xFF130160),
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30), // Espace en bas
          ],
        ),
      ),
    );
  }
}
