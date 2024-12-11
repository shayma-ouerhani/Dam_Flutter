//
// import 'package:damdleaders_flutter/Controllers/HomeController.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AddPostScreen(),
//     );
//   }
// }
//
// class AddPostScreen extends StatefulWidget {
//   @override
//   State<AddPostScreen> createState() => _AddPostScreenState();
// }
//
// class _AddPostScreenState extends State<AddPostScreen> {
//
//   final controller = HomeController();
//   File? _selectedVideo; // Fichier vidéo sélectionné
//   VideoPlayerController? _videoController; // Contrôleur pour le lecteur vidéo
//   final ImagePicker _picker = ImagePicker(); // Instance du sélecteur
//
//   // Fonction pour sélectionner une vidéo depuis la galerie
//   Future<void> _pickVideo() async {
//     try {
//       final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
//       if (video != null) {
//         setState(() {
//           _selectedVideo = File(video.path);
//           _videoController = VideoPlayerController.file(_selectedVideo!)
//             ..initialize().then((_) {
//               setState(() {}); // Rafraîchit l'interface après l'initialisation
//               _videoController!.play(); // Lance la lecture automatiquement
//             });
//         });
//       }
//     } catch (e) {
//       print("Erreur lors de la sélection de la vidéo : $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     // Libère les ressources du contrôleur vidéo
//     _videoController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 27.0), // Espacement en haut de la page
//
//             const Row(
//               children: [
//                 CircleAvatar(
//                   radius: 25,
//                   backgroundImage: NetworkImage(
//                       "https://res.cloudinary.com/dcjtuxprn/image/upload/v1732755984/UploadLeaders/1000014203.jpg"), // Remplace par l'image de l'utilisateur
//                 ),
//                 SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "yesser khaloui",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       "software developer",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Post title",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter title here",
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Description",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter description here",
//               ),
//               maxLines: 4,
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.video_library,
//                     color: Color(0xFFFF9228),
//                   ),
//                   onPressed: _pickVideo, // Appel correct de la fonction
//                 ),
//                 const Text("Add a video"),
//               ],
//             ),
//             if (_selectedVideo != null) // Affiche une vidéo si sélectionnée
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: SizedBox(
//                   height: 100,
//                   child: _videoController != null && _videoController!.value.isInitialized
//                       ? AspectRatio(
//                     aspectRatio: _videoController!.value.aspectRatio,
//                     child: VideoPlayer(_videoController!),
//                   )
//                       : const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               ),
//             const Spacer(),
//             Row(
//               children: [
//                 Spacer(), // Espace pour décaler à droite
//                 TextButton(
//                   onPressed: () {
//                       controller.addPost(title: title.name, description: description, user: user, videoFile: videoFile)
//
//                     // Action du bouton "Post" sans arrière-plan
//                   },
//                   child: Text(
//                     "Post",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Color(0xFFFF9228),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:damdleaders_flutter/Controllers/HomeController.dart';
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
  File? _selectedVideo; // Fichier vidéo sélectionné
  VideoPlayerController? _videoController; // Contrôleur pour le lecteur vidéo
  final ImagePicker _picker = ImagePicker(); // Instance du sélecteur
  String title = '';
  String description = '';
  String user = 'yesser khaloui'; // Remplacer par l'utilisateur actuel

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
              _videoController!.play(); // Lance la lecture automatiquement
            });
        });
      }
    } catch (e) {
      print("Erreur lors de la sélection de la vidéo : $e");
    }
  }

  @override
  void dispose() {
    // Libère les ressources du contrôleur vidéo
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 27.0), // Espacement en haut de la page

            const Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      "https://res.cloudinary.com/dcjtuxprn/image/upload/v1732755984/UploadLeaders/1000014203.jpg"), // Remplace par l'image de l'utilisateur
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "yesser khaloui",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "software developer",
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
            TextField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
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
            TextField(
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
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
                  height: 100,
                  child: _videoController != null && _videoController!.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            const Spacer(),
            Row(
              children: [
                Spacer(), // Espace pour décaler à droite
                TextButton(
                  onPressed: () {
                    if (_selectedVideo != null && title.isNotEmpty && description.isNotEmpty) {
                      controller.addPost(
                        title: title,
                        description: description,
                        user: "67322ac07b0ef3c99e6a288c",
                        videoFile: _selectedVideo!,
                      );
                    } else {
                      print("Veuillez remplir tous les champs et sélectionner une vidéo.");
                    }
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
    );
  }
}
