import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:damdleaders_flutter/Controllers/AuthController.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileView> {
  final HomeController _homeController =
      HomeController(); // Instance of API controller
  final AuthController _authController = AuthController();

  File? _selectedImage;
  File? _selectedPdfFile;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _domainController = TextEditingController();
  final _githubController = TextEditingController();

  bool _isEditingAboutMe = false;
  bool _isEditingSkill = false;
  bool _isEditingResume = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _domainController.dispose();
    _phoneNumberController.dispose();
    _githubController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Restrict to PDF files
    );

    if (result != null) {
      setState(() {
        _selectedPdfFile = File(result.files.single.path!);
      });
    } else {
      print('No file selected');
    }
  }

  Future<void> _saveProfile() async {
    try {
      final user = _authController.getCurrentUser();
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user is currently logged in.")),
        );
        return;
      }

      final userId = user.uid;
      final profileData = {
        "name": _firstNameController.text.isNotEmpty
            ? _firstNameController.text
            : null,
        "lastname": _lastNameController.text.isNotEmpty
            ? _lastNameController.text
            : null,
        "email":
            _emailController.text.isNotEmpty ? _emailController.text : null,
      };

      final response = await _homeController.updateUserProfile(
        userId,
        profileData,
        _selectedImage,
      );

      if (response.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $e")),
      );
    }
  }

  Future<void> _loadUserData() async {
    try {
      final user = _authController.getCurrentUser();
      if (user != null) {
        final userId = user.uid;
        final userData = await _authController.fetchUserData(userId);
        setState(() {
          _firstNameController.text = userData['name'] ?? '';
          _lastNameController.text = userData['lastname'] ?? '';
          _emailController.text = userData['email'] ?? '';
        });
      } else {
        print("No user is currently logged in.");
      }
    } catch (e) {
      print("Error loading user data: $e");
    } finally {
      setState(() {
        // _isLoading = false;
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
              Stack(
                children: [
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
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : const AssetImage('assets/yassineImage.jpg')
                                    as ImageProvider,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${_firstNameController.text} ${_lastNameController.text}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _domainController.text,
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
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Navigate back
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black45,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Editable Card - About Me
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 24.0,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'ABOUT ME',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              _isEditingAboutMe
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                            onPressed: () {
                              setState(() {
                                _isEditingAboutMe = !_isEditingAboutMe;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_isEditingAboutMe) ...[
                        const SizedBox(height: 10),
                        TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ]
                    ],
                  ),
                ),
              ),

              // Skill Card
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.school,
                                size: 24.0,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Skill',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              _isEditingSkill
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                            onPressed: () {
                              setState(() {
                                _isEditingSkill = !_isEditingSkill;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_isEditingSkill) ...[
                        const SizedBox(height: 10),
                        TextField(
                          controller: _domainController,
                          decoration: const InputDecoration(
                            labelText: 'Domain',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _githubController,
                          decoration: const InputDecoration(
                            labelText: 'GitHub',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ]
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: _saveProfile, // Save Profile
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 48, 0, 131),
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
