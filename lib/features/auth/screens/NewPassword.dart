// import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';
// import 'package:flutter/material.dart';
//
// class NewPasswordScreen extends StatefulWidget {
//
//    final String resetToken;
//
//   const NewPasswordScreen({
//     Key? key,
//     required this.resetToken,
// }) : super(key: key);
//
//   @override
//   _NewPasswordScreenState createState() => _NewPasswordScreenState();
// }
//
// class _NewPasswordScreenState extends State<NewPasswordScreen> {
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   bool isPasswordVisible = false;
//   bool isConfirmPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Enter New Password',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF130160),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 "Let's log in. Apply to jobs!",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 40),
//
//               // Password Field
//               TextField(
//                 controller: passwordController,
//                 obscureText: !isPasswordVisible,
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                   prefixIcon: const Icon(Icons.lock),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         isPasswordVisible = !isPasswordVisible;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: const BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: const BorderSide(color: Color(0xFF130160)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Confirm Password Field
//               TextField(
//                 controller: confirmPasswordController,
//                 obscureText: !isConfirmPasswordVisible,
//                 decoration: InputDecoration(
//                   hintText: 'Confirm Password',
//                   prefixIcon: const Icon(Icons.lock),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       isConfirmPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         isConfirmPasswordVisible = !isConfirmPasswordVisible;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: const BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: const BorderSide(color: Color(0xFF130160)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//
//               // Save Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF130160),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 120),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'SAVE',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert'; // Pour json.encode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String resetToken;

  const NewPasswordScreen({
    Key? key,
    required this.resetToken,
  }) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  // Fonction de réinitialisation du mot de passe
  Future<Map<String, dynamic>> resetPassword(String resetToken, String newPassword) async {
    final response = await http.put(
      Uri.parse("http://192.168.1.129:3000/auth/reset-password"), // Remplacez par l'URL réelle
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'resetToken': resetToken,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print(response);
      // Si la requête réussit, retournez les données de la réponse
      return json.decode(response.body);
    } else {
      print("objec ${response.body}response.");
      // Si la requête échoue, lancez une exception
      throw Exception('Failed to reset password');

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter New Password',
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

              // Password Field
              TextField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
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
              const SizedBox(height: 20),

              // Confirm Password Field
              TextField(
                controller: confirmPasswordController,
                obscureText: !isConfirmPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
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
              const SizedBox(height: 40),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Vérifier si les mots de passe correspondent
                    if (passwordController.text == confirmPasswordController.text) {
                      try {
                        print("11111111111111111111");
                        // Appel à la méthode de réinitialisation du mot de passe
                        await resetPassword(widget.resetToken, passwordController.text);

                        // Si la réinitialisation réussit, rediriger vers la page de connexion
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      } catch (e) {
                        print("object");
                        // Si une erreur survient, afficher un message d'erreur
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    } else {
                      // Si les mots de passe ne correspondent pas
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF130160),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
