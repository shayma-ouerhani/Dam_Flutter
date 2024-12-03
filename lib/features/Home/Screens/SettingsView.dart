// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';


class SettingsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
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
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://res.cloudinary.com/dcjtuxprn/image/upload/v1733151304/UploadLeaders/image.jpg', // Replace with the user's profile picture URL
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ajbouni Yassine',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'yassine.ajbouni@esprit.tn',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Tunisia, Tunis',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Divider(),
              // Dark Mode Toggle
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark mode'),
                trailing: Switch(
                  value: false,
                  onChanged: (bool value) {
                    // Handle dark mode toggle
                  },
                ),
              ),
              const Divider(),

              // Password Option
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Password'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showEditPasswordDialog(context);
                // Show password change popup
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return PasswordChangeDialog();
                //   },
                // );
              },
              ),
              const Divider(),

              // Logout Option
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 55,),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle the logout logic here
                                  Navigator.of(context).pop(); // Close the dialog
                                  // Add your logout logic
                                },
                                // style: ElevatedButton.styleFrom(
                                //   backgroundColor: Colors.red, // Customize button color
                                // ),
                                child: const Text('Logout',
                                style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      );
                    },
                  );
                },
              ),

              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}


void _showEditPasswordDialog(BuildContext context) {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            const Text(
                      'Change your Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            const SizedBox(height: 16),
            // Old Password field with eye icon
            TextField(
              controller: oldPasswordController,
              obscureText: _obscureOldPassword,
              decoration: InputDecoration(
                labelText: 'Old Password',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureOldPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Toggle the visibility
                    _obscureOldPassword = !_obscureOldPassword;
                    (context as Element).markNeedsBuild();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // New Password field with eye icon
            TextField(
              controller: newPasswordController,
              obscureText: _obscureNewPassword,
              decoration: InputDecoration(
                labelText: 'New Password',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Toggle the visibility
                    _obscureNewPassword = !_obscureNewPassword;
                    (context as Element).markNeedsBuild();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Confirm New Password field with eye icon
            TextField(
              controller: confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Toggle the visibility
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                    (context as Element).markNeedsBuild();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Buttons for Save and Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle the saving logic here
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}


// class PasswordChangeDialog extends StatefulWidget {
//   @override
//   _PasswordChangeDialogState createState() => _PasswordChangeDialogState();
// }

// class _PasswordChangeDialogState extends State<PasswordChangeDialog> {
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   bool _isCurrentPasswordVisible = false;
//   bool _isNewPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Update Password',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Current Password Field
//             TextField(
//               controller: _passwordController,
//               obscureText: !_isCurrentPasswordVisible,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isCurrentPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
//                     });
//                   },
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),

//             // New Password Field
//             TextField(
//               controller: _newPasswordController,
//               obscureText: !_isNewPasswordVisible,
//               decoration: InputDecoration(
//                 labelText: 'New Password',
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isNewPasswordVisible = !_isNewPasswordVisible;
//                     });
//                   },
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),

//             // Confirm Password Field
//             TextField(
//               controller: _confirmPasswordController,
//               obscureText: !_isConfirmPasswordVisible,
//               decoration: InputDecoration(
//                 labelText: 'Confirm Password',
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                     });
//                   },
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Confirm Button
//             ElevatedButton(
//               onPressed: () {
//                 // Handle password update logic
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF4A148C), // Matches your design
//                 padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: const Text(
//                 'CONFIRM',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white, // Ensure the text is white
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
