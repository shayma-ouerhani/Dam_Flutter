import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
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

// Variables pour stocker les informations utilisateur
  String? userName;
  String? userLastName;
  String? userDomaine;
  String? userId;
  String? photoUrl;
  String? userEmail;
  String? userPhoneNumber;
  String? userGithub;
  bool isLoadingUserData = true; // Indicateur de chargement


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

  Future<void> _saveProfile(id) async {
    try {
      /*final user = _authController.getCurrentUser();
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user is currently logged in.")),
        );
        return;
      }*/

      final userId = id;
      //final userId = user.uid;
      final profileData = {
        "name": _firstNameController.text.isNotEmpty
            ? _firstNameController.text
            : null,
        "lastname": _lastNameController.text.isNotEmpty
            ? _lastNameController.text
            : null,
        "email":
            _emailController.text.isNotEmpty ? _emailController.text : null,
        "domaine":
            _domainController.text.isNotEmpty ? _domainController.text : null,
        "website":
            _githubController.text.isNotEmpty ? _githubController.text : null,
        "phoneNumber":
            _phoneNumberController.text.isNotEmpty ? _phoneNumberController.text : null,
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
    // Attempt to get user data from preferences
    userName = await UserPreference.getName();
    userLastName = await UserPreference.getLastName();
    userDomaine = await UserPreference.getDomaine();
    userEmail = await UserPreference.getEmail();
    userId = await UserPreference.getUserId();
    photoUrl = await UserPreference.getPhotoUrl();
    userGithub = await UserPreference.getWebsite();
    userPhoneNumber = await UserPreference.getPhoneNumber();
    // Debug print statements
    print('userName: $userName');
    print('userLastName: $userLastName');
    print('userDomaine: $userDomaine');
  } catch (e) {
    print("Erreur lors de la récupération des données utilisateur : $e");
  } finally {
    // Make sure to check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        isLoadingUserData = false;
        // Set the text of the controller if the value is not null
        _firstNameController.text = userName ?? ''; // Safe fallback
        _lastNameController.text = userLastName ?? '';
        _emailController.text = userEmail ?? '';
        _domainController.text = userDomaine ?? '';
        _githubController.text = userGithub ?? '';
        _phoneNumberController.text = userPhoneNumber ?? '';
      });
    }
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
                          child: 
                          CircleAvatar(
                            radius: 35,
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
                          /*CircleAvatar(
                            radius: 50,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : const AssetImage('assets/yassineImage.jpg')
                                    as ImageProvider,
                          ),*/
                        ),
                        const SizedBox(height: 10),
                        Text(
                          //"${_firstNameController.text} ${_lastNameController.text}",
                          "${userName ?? 'Name'} ${userLastName ?? 'Last Name'}",
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
                onPressed: () async {
                  await _saveProfile(userId); // Save Profile asynchronously
                },
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
