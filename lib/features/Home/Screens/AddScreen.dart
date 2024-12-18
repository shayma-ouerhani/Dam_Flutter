import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
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
  final controller = HomeController();
  File? _selectedVideo;
  VideoPlayerController? _videoController;
  final ImagePicker _picker = ImagePicker();

  String title = '';
  String description = '';
  String? userName;
  String? userLastName;
  String? userDomaine;
  String? photoUrl;

  bool isLoadingUserData = true;

  // Fonction pour sélectionner une vidéo depuis la galerie
  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        setState(() {
          _selectedVideo = File(video.path);
          _videoController = VideoPlayerController.file(_selectedVideo!)
            ..initialize().then((_) {
              setState(() {}); // Rafraîchit l'interface après l'initialisation
              _videoController!.play();
            });
        });
      }
    } catch (e) {
      print("Erreur lors de la sélection de la vidéo : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      userName = await UserPreference.getName();
      userLastName = await UserPreference.getLastName();
      userDomaine = await UserPreference.getDomaine();
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur : $e");
    } finally {
      setState(() {
        isLoadingUserData = false;
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoadingUserData
            ? const Center(
                child: CircularProgressIndicator()) // Affiche un loader
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 27.0),
                        Row(
                          children: [
                            /*const CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  "https://res.cloudinary.com/dcjtuxprn/image/upload/v1733872892/UploadLeaders/Messenger_creation_CE9410BB-0794-4261-88AC-60CD8F180A91.jpg"),
                            ),*/
                            CircleAvatar(
                              radius: 25,
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
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userName ?? 'Name'} ${userLastName ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  userDomaine ?? 'Domaine',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Post title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter title here",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                          decoration: const InputDecoration(
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
                              onPressed: _pickVideo,
                            ),
                            const Text("Add a video"),
                          ],
                        ),
                        if (_selectedVideo != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                              height: 100,
                              child: _videoController != null &&
                                      _videoController!.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _videoController!.value.aspectRatio,
                                      child: VideoPlayer(_videoController!),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedVideo != null &&
                                title.isNotEmpty &&
                                description.isNotEmpty) {
                              controller.addPost(
                                title: title,
                                description: description,
                                user: "67322ac07b0ef3c99e6a288c",
                                videoFile: _selectedVideo!,
                              );
                            } else {
                              print(
                                  "Veuillez remplir tous les champs et sélectionner une vidéo.");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFFFF9228),
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Post",
                            style: TextStyle(
                              color: Color(0xFFFF9228),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
