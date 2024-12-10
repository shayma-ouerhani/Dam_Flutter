// import 'package:damdleaders_flutter/features/Home/Screens/homeScreen.dart';
// import 'package:damdleaders_flutter/features/Liste_Condidat.dart';
// import 'package:damdleaders_flutter/features/auth/screens/Forget_Password.dart';
// import 'package:damdleaders_flutter/features/auth/screens/register_screen.dart';
// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 150),
//
//                 const Text(
//                   'Welcome Back',
//                   style: TextStyle(
//                     fontSize: 28,
//                     color: Color(0xFF130160),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Text(
//                   "Let's Login Apply to Jobs",
//                   style: TextStyle(fontSize: 18, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 40),
//
//                 // Champ Email avec validation
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'E-mail',
//                     prefixIcon: Icon(Icons.email),
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     final emailRegex = RegExp(
//                         r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
//                     if (!emailRegex.hasMatch(value)) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Champ Password avec validation
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: Icon(Icons.lock),
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     return null;
//                   },
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ForgetPasswordScreen()),
//                       );
//                     },
//                     child: const Text(
//                       'Forget Password?',
//                       style: TextStyle(
//                         color: Color(0xFF130160),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Bouton de connexion
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         // Connexion réussie
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: const Text("Login Successful"),
//                             content:
//                                 const Text("You have successfully logged in!"),
//                             actions: [
//                               TextButton(
//                                 onPressed: (){
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       //builder: (context) => ListeCondidat()),
//                                         builder: (context) => const HomeScreen()),
//                                   );
//                                 },
//                                 child: const Text("OK"),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         // Affiche un pop-up d'erreur
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: const Text("Invalid User"),
//                             content: const Text(
//                                 "Please check your email or password."),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: const Text("OK"),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF130160),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 15, horizontal: 140),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Lien pour l'inscription
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("You don't have an account yet?"),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               //builder: (context) => ListeCondidat()),
//                               builder: (context) => HomeScreen()),
//                         );
//                       },
//                       child: const Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF130160),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:damdleaders_flutter/features/auth/screens/Forget_Password.dart';
import 'package:damdleaders_flutter/features/auth/screens/register_screen.dart';
import 'package:damdleaders_flutter/shared/login_text_fields.dart';
import 'package:flutter/material.dart';


import '../../../Controllers/AuthController.dart';
import '../../Home/Screens/homeScreen.dart'; // Assurez-vous d'importer HomeScreen

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Méthode pour gérer la connexion
  void handleLogin(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    // Appel de la fonction de connexion
    AuthController authController = AuthController();

    // Supposons que login retourne un LoginResponse
    var response = await authController.login(email, password);

    if (response != null && response.statusCode == 200) {  // Vérifier si le code de réponse est 201
      // Si la connexion réussit et que le code est 201, rediriger vers HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Assurez-vous que HomeScreen est défini
      );
    } else {
      // Si la connexion échoue, afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Échec de la connexion. Vérifiez vos identifiants."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Color(0xFF130160),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Bouton de connexion
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    handleLogin(context); // Appel de la méthode handleLogin
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
                            builder: (context) => RegisterScreen()),
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

