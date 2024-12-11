import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddPostScreen(),
    );
  }
}

class AddPostScreen extends StatefulWidget {
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _selectedVideo; // Fichier vidéo sélectionné
  final ImagePicker _picker = ImagePicker(); // Instance du sélecteur

  // Fonction pour sélectionner une vidéo depuis la galerie
  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        setState(() {
          _selectedVideo = File(video.path);
        });
      }
    } catch (e) {
      print("Erreur lors de la sélection de la vidéo : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://res.cloudinary.com/dcjtuxprn/image/upload/v1733872892/UploadLeaders/Messenger_creation_CE9410BB-0794-4261-88AC-60CD8F180A91.jpg"), // Remplace par l'image de l'utilisateur
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yassine Ajbouni",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Flutter Developer",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Post title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter title here",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter description here",
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.video_library,
                      color: Color(0xFFFF9228),
                    ),
                    onPressed: _pickVideo, // Appel correct de la fonction
                  ),
                  const Text("Add a video"),
                ],
              ),
              if (_selectedVideo != null) // Affiche une vidéo si sélectionnée
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        "Video selected: ${_selectedVideo!.path.split('/').last}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              Row(
                children: [
                  Spacer(), // Espace pour décaler à droite
                  TextButton(
                    onPressed: () {
                      // Action du bouton "Post" sans arrière-plan
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFFF9228),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
