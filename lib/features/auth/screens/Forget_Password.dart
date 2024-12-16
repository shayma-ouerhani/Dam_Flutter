import 'package:damdleaders_flutter/features/auth/screens/OTP.dart';
import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Pour l'encodage JSON
import 'package:http/http.dart' as http;

import 'NewPassword.dart'; // Assurez-vous que cette importation est présente

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _emailError = '';
  String _smsError = '';
  bool _isLoading = false;

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();
    final sms = _smsController.text.trim();

    if (email.isEmpty && sms.isEmpty) {
      setState(() {
        _emailError = "Please enter an email or phone number.";
        _smsError = "Please enter an email or phone number.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _emailError = '';
      _smsError = '';
    });

    try {
      final url = Uri.parse('http://192.168.1.7:3000/auth/forgot-password');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email
          // "phoneNumber": sms,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(data); // Debug : affiche la réponse complète
        if (data["statusCode"] == 200) {
          // Votre logique ici
          print(data);

          // Redirection vers la page OTP
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                resetToken: data["resetToken"],
                code: data["code"],
              ),
            ),
          );
        } else {
          _showSnackbar("Failed to send OTP. Try again.");
        }
      } else {
        print("object   $response");
        _showSnackbar("Invalid response from server. Status code: ${response.statusCode}");
      }

    } catch (e) {
      _showSnackbar("An error occurred. Check your connection.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF130160),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF130160)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Icon(
                    Icons.lock,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _smsController,
                  decoration: InputDecoration(
                    labelText: "Enter your phone number",
                    prefixIcon: Icon(Icons.call),
                    errorText: _smsError.isEmpty ? null : _smsError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _smsError = ''; // Clear error on input
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Enter your email",
                    prefixIcon: Icon(Icons.mail_outline),
                    errorText: _emailError.isEmpty ? null : _emailError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _emailError = ''; // Clear error on input
                    });
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity, // Le bouton prendra toute la largeur disponible
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleForgotPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF130160),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'CONTINUE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6CDFE),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Back To Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF130160),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _smsController.dispose();
    super.dispose();
  }
}



class OtpScreen extends StatefulWidget {
  final String resetToken;
  final int code;

  const OtpScreen({
    Key? key,
    required this.resetToken,
    required this.code,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Liste des contrôleurs pour chaque champ de l'OTP
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());

  // Fonction pour vérifier l'OTP et passer à l'écran NewPasswordScreen
  void _verifyOtp() {
    // Récupérer le code saisi par l'utilisateur
    String userOtp = _otpControllers.map((controller) => controller.text).join();

    // Comparer avec le code généré
    if (userOtp == widget.code.toString()) {
      // Si l'OTP est correct, naviguer vers NewPasswordScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewPasswordScreen(resetToken: widget.resetToken),
        ),
      );
    } else {
      // Afficher un message d'erreur si l'OTP est incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter OTP Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF130160),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Let's log in. Apply to jobs!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF130160),
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Color(0xFF130160)),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),

              // Send Code Button
              ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF130160),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'VERIFY OTP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Resend Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You have not received the code? ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Action pour renvoyer le code
                    },
                    child: const Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: 14,
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
