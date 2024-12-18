import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
import 'package:damdleaders_flutter/config/theme/theme_provider.dart';
import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String? userName;
  String? userLastName;
  String? userEmail;
  bool isLoadingUserData = true;
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      userName = await UserPreference.getName();
      userLastName = await UserPreference.getLastName();
      userEmail = await UserPreference.getEmail();
      photoUrl = await UserPreference.getPhotoUrl();
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur : $e");
    } finally {
      setState(() {
        isLoadingUserData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF301060), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    /*CircleAvatar(
                      radius: 50,
                      backgroundImage: photoUrl != null
                          ? NetworkImage(photoUrl!) // Utiliser NetworkImage pour une URL
                          : AssetImage('assets/yassineImage.jpg') as ImageProvider, // Image par défaut
                    ),*/
                    CircleAvatar(
                    radius: 50,
                    backgroundImage: photoUrl != null && photoUrl!.isNotEmpty
                        ? NetworkImage(photoUrl!)
                        : null,
                    child: photoUrl == null || photoUrl!.isEmpty
                        ? Icon(Icons.person, size: 30) // Placeholder
                        : null,
                    onBackgroundImageError: (_, __) {
                      print('Failed to load image');
                    },
                  ),
                    const SizedBox(height: 10),
                    Text(
                      "${userName ?? 'Name'} ${userLastName ?? ''}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userEmail ?? 'email@example.com',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Dark Mode Toggle
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.dark_mode,
                            size: 24.0,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Dark mode',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, _) {
                          return Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (bool value) {
                              themeProvider.toggleTheme(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Password Update
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: 24.0,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Password',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          _showEditPasswordDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Logout
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 24.0,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Logout'),
                                content: const Text(
                                    'Are you sure you want to logout?'),
                                actions: [
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(width: 55),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     UserPreference.setUserLoggedIn(true); // Marquer l'utilisateur comme connecté
                                      //     Navigator.of(context).pop();
                                      //     // Add logout logic here
                                      //   },
                                      //   child: const Text(
                                      //     'Logout',
                                      //     style: TextStyle(color: Colors.red),
                                      //   ),
                                      // ),
                                      ElevatedButton(
  onPressed: () {
    UserPreference.setUserLoggedIn(false); // Mark the user as logged out
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to the login screen
    );
    Navigator.of(context).pop(); // Close the current screen (optional)
  },
  child: const Text(
    'Logout',
    style: TextStyle(color: Colors.red),
  ),
)

                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditPasswordDialog(BuildContext context) {
    final TextEditingController oldPasswordController =
    TextEditingController();
    final TextEditingController newPasswordController =
    TextEditingController();
    final TextEditingController confirmPasswordController =
    TextEditingController();

    bool _obscurePassword = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change your Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: _obscurePassword,
              decoration: const InputDecoration(labelText: 'Old Password'),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: _obscurePassword,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: _obscurePassword,
              decoration:
              const InputDecoration(labelText: 'Confirm New Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (newPasswordController.text ==
                  confirmPasswordController.text) {
                Navigator.of(context).pop();
                // Handle password change logic
              } else {
                print('Passwords do not match!');
              }
            },
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
