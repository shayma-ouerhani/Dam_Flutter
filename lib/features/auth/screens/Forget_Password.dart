import 'package:damdleaders_flutter/features/auth/screens/OTP.dart';
import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Pour l'encodage JSON
import 'package:http/http.dart' as http; // Assurez-vous que cette importation est présente

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
      final url = Uri.parse('http://your-backend-url.com/auth/forgot-password');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "phoneNumber": sms,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["statusCode"] == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                resetToken: data["resetToken"], // Paramètre ajouté ici
                code: data["code"], // Paramètre ajouté ici
              ),
            ),
          );
        } else {
          _showSnackbar("Failed to send OTP. Try again.");
        }
      } else {
        _showSnackbar("Invalid response from server.");
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

class OtpScreen extends StatelessWidget {
  final String resetToken;
  final int code;

  const OtpScreen({
    Key? key,
    required this.resetToken,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Center(
        child: Text("Token: $resetToken, Code: $code"),
      ),
    );
  }
}
