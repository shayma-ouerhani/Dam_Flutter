import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileView> {
  File? _selectedImage;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isEditingAboutMe = false;
  bool _isEditingSkill = false;
  bool _isEditingResume = false;
  late String _selectedPdf = "cv_pdf_file";

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header with Photo Picker
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(0, 51, 32, 133), Color.fromARGB(255, 39, 14, 108)],                    
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
                            : const AssetImage('assets/yassineImage.jpg') as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Yassine Ajbouni',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Yassine.Ajbouni@esprit.tn',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
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
                              const Icon(
                                Icons.info,
                                size: 24.0,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'ABOUT ME',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              _isEditingAboutMe ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
                          controller: _emailController,
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
                              const Icon(
                                Icons.info,
                                size: 24.0,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Skill',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              _isEditingSkill ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
                          decoration: const InputDecoration(
                            labelText: 'Domain',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
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
                              const Icon(
                                Icons.info,
                                size: 24.0,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Resume',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          IconButton(
                            icon: Icon(
                              _isEditingResume ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            ),
                            onPressed: () {
                              setState(() {
                                _isEditingResume = !_isEditingResume;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_isEditingResume) ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  _selectedPdf != null ? _selectedPdf!.split('/').last : 'No file selected',
                                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            /*IconButton(
                              icon: const Icon(Icons.upload_file_rounded,size: 40,),
                              onPressed: () {
                                setState(() {
                                  _isEditingResume = !_isEditingResume;
                                });
                              },
                            ),*/
                            IconButton(
                              icon: const Icon(Icons.upload_file_rounded),
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf'], // Restrict to PDF files
                                );

                                if (result != null) {
                                  String filePath = result.files.single.path!;
                                  setState(() {
                                    // Do something with the selected file (e.g., update UI)
                                    _selectedPdf = filePath; // Assuming `_selectedPdf` is a String variable to hold the file path
                                  });

                                  // Optionally, handle the file upload process here
                                  print('Selected PDF Path: $filePath');
                                } else {
                                  // User canceled the picker
                                  print('No file selected');
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ]
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  // Save the updated data
                  setState(() {
                    // Add your save logic here
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
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
