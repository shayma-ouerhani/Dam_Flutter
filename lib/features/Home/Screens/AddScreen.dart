// // //
// // // import 'package:damdleaders_flutter/Controllers/HomeController.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:video_player/video_player.dart';
// // // import 'dart:io';
// // //
// // // void main() => runApp(MyApp());
// // //
// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: AddPostScreen(),
// // //     );
// // //   }
// // // }
// // //
// // // class AddPostScreen extends StatefulWidget {
// // //   @override
// // //   State<AddPostScreen> createState() => _AddPostScreenState();
// // // }
// // //
// // // class _AddPostScreenState extends State<AddPostScreen> {
// // //
// // //   final controller = HomeController();
// // //   File? _selectedVideo; // Fichier vidéo sélectionné
// // //   VideoPlayerController? _videoController; // Contrôleur pour le lecteur vidéo
// // //   final ImagePicker _picker = ImagePicker(); // Instance du sélecteur
// // //
// // //   // Fonction pour sélectionner une vidéo depuis la galerie
// // //   Future<void> _pickVideo() async {
// // //     try {
// // //       final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
// // //       if (video != null) {
// // //         setState(() {
// // //           _selectedVideo = File(video.path);
// // //           _videoController = VideoPlayerController.file(_selectedVideo!)
// // //             ..initialize().then((_) {
// // //               setState(() {}); // Rafraîchit l'interface après l'initialisation
// // //               _videoController!.play(); // Lance la lecture automatiquement
// // //             });
// // //         });
// // //       }
// // //     } catch (e) {
// // //       print("Erreur lors de la sélection de la vidéo : $e");
// // //     }
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     // Libère les ressources du contrôleur vidéo
// // //     _videoController?.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             SizedBox(height: 27.0), // Espacement en haut de la page
// // //
// // //             const Row(
// // //               children: [
// // //                 CircleAvatar(
// // //                   radius: 25,
// // //                   backgroundImage: NetworkImage(
// // //                       "https://res.cloudinary.com/dcjtuxprn/image/upload/v1732755984/UploadLeaders/1000014203.jpg"), // Remplace par l'image de l'utilisateur
// // //                 ),
// // //                 SizedBox(width: 10),
// // //                 Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       "yesser khaloui",
// // //                       style: TextStyle(
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 16,
// // //                       ),
// // //                     ),
// // //                     Text(
// // //                       "software developer",
// // //                       style: TextStyle(color: Colors.grey),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 20),
// // //             const Text(
// // //               "Post title",
// // //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //             ),
// // //             const TextField(
// // //               decoration: InputDecoration(
// // //                 border: OutlineInputBorder(),
// // //                 hintText: "Enter title here",
// // //               ),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             const Text(
// // //               "Description",
// // //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //             ),
// // //             const TextField(
// // //               decoration: InputDecoration(
// // //                 border: OutlineInputBorder(),
// // //                 hintText: "Enter description here",
// // //               ),
// // //               maxLines: 4,
// // //             ),
// // //             const SizedBox(height: 20),
// // //             Row(
// // //               children: [
// // //                 IconButton(
// // //                   icon: const Icon(
// // //                     Icons.video_library,
// // //                     color: Color(0xFFFF9228),
// // //                   ),
// // //                   onPressed: _pickVideo, // Appel correct de la fonction
// // //                 ),
// // //                 const Text("Add a video"),
// // //               ],
// // //             ),
// // //             if (_selectedVideo != null) // Affiche une vidéo si sélectionnée
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(vertical: 20),
// // //                 child: SizedBox(
// // //                   height: 100,
// // //                   child: _videoController != null && _videoController!.value.isInitialized
// // //                       ? AspectRatio(
// // //                     aspectRatio: _videoController!.value.aspectRatio,
// // //                     child: VideoPlayer(_videoController!),
// // //                   )
// // //                       : const Center(
// // //                     child: CircularProgressIndicator(),
// // //                   ),
// // //                 ),
// // //               ),
// // //             const Spacer(),
// // //             Row(
// // //               children: [
// // //                 Spacer(), // Espace pour décaler à droite
// // //                 TextButton(
// // //                   onPressed: () {
// // //                       controller.addPost(title: title.name, description: description, user: user, videoFile: videoFile)
// // //
// // //                     // Action du bouton "Post" sans arrière-plan
// // //                   },
// // //                   child: Text(
// // //                     "Post",
// // //                     style: TextStyle(
// // //                       fontSize: 18,
// // //                       color: Color(0xFFFF9228),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:damdleaders_flutter/Controllers/HomeController.dart';
// // import 'package:damdleaders_flutter/features/Widgets/notification.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:video_player/video_player.dart';
// // import 'dart:io';
// //
// // void main() => runApp(MyApp());
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: AddPostScreen(),
// //     );
// //   }
// // }
// //
// // class AddPostScreen extends StatefulWidget {
// //   @override
// //   State<AddPostScreen> createState() => _AddPostScreenState();
// // }
// //
// // class _AddPostScreenState extends State<AddPostScreen> {
// //
// //   final notif =  NotificationScreenState();
// //
// //   final controller = HomeController();
// //   File? _selectedVideo; // Fichier vidéo sélectionné
// //   VideoPlayerController? _videoController; // Contrôleur pour le lecteur vidéo
// //   final ImagePicker _picker = ImagePicker(); // Instance du sélecteur
// //   String title = '';
// //   String description = '';
// //   String user = 'yesser khaloui'; // Remplacer par l'utilisateur actuel
// //
// //   // Fonction pour sélectionner une vidéo depuis la galerie
// //   Future<void> _pickVideo() async {
// //     try {
// //       final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
// //       if (video != null) {
// //         setState(() {
// //           _selectedVideo = File(video.path);
// //           _videoController = VideoPlayerController.file(_selectedVideo!)
// //             ..initialize().then((_) {
// //               setState(() {}); // Rafraîchit l'interface après l'initialisation
// //               _videoController!.play(); // Lance la lecture automatiquement
// //             });
// //         });
// //       }
// //     } catch (e) {
// //       print("Erreur lors de la sélection de la vidéo : $e");
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     // Libère les ressources du contrôleur vidéo
// //     _videoController?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(height: 27.0), // Espacement en haut de la page
// //             const Row(
// //               children: [
// //                 CircleAvatar(
// //                   radius: 25,
// //                   backgroundImage: NetworkImage(
// //                       "https://res.cloudinary.com/dcjtuxprn/image/upload/v1733872892/UploadLeaders/Messenger_creation_CE9410BB-0794-4261-88AC-60CD8F180A91.jpg"), // Remplace par l'image de l'utilisateur
// //                 ),
// //                 SizedBox(width: 10),
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "Yassine Ajbouni",
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 16,
// //                       ),
// //                     ),
// //                     Text(
// //                       "Flutter Developer",
// //                       style: TextStyle(color: Colors.grey),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               "Post title",
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //             TextField(
// //               onChanged: (value) {
// //                 setState(() {
// //                   title = value;
// //                 });
// //               },
// //               decoration: InputDecoration(
// //                 border: OutlineInputBorder(),
// //                 hintText: "Enter title here",
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               "Description",
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //             TextField(
// //               onChanged: (value) {
// //                 setState(() {
// //                   description = value;
// //                 });
// //               },
// //               decoration: InputDecoration(
// //                 border: OutlineInputBorder(),
// //                 hintText: "Enter description here",
// //               ),
// //               maxLines: 4,
// //             ),
// //             const SizedBox(height: 20),
// //             Row(
// //               children: [
// //                 IconButton(
// //                   icon: const Icon(
// //                     Icons.video_library,
// //                     color: Color(0xFFFF9228),
// //                   ),
// //                   onPressed: _pickVideo, // Appel correct de la fonction
// //                 ),
// //                 const Text("Add a video"),
// //               ],
// //             ),
// //             if (_selectedVideo != null) // Affiche une vidéo si sélectionnée
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 20),
// //                 child: SizedBox(
// //                   height: 100,
// //                   child: _videoController != null && _videoController!.value.isInitialized
// //                       ? AspectRatio(
// //                     aspectRatio: _videoController!.value.aspectRatio,
// //                     child: VideoPlayer(_videoController!),
// //                   )
// //                       : const Center(
// //                     child: CircularProgressIndicator(),
// //                   ),
// //                 ),
// //               ),
// //             const Spacer(),
// //             Row(
// //               children: [
// //                 const Spacer(), // Espace pour décaler à droite
// //                 TextButton(
// //                   onPressed: () {
// //                     print("11111111111111111111111111111111111");
// //                     notif.showNotification();
// //                     print("22222222222222222222222222222222222222");
// //                     if (_selectedVideo != null && title.isNotEmpty && description.isNotEmpty) {
// //                       controller.addPost(
// //                         title: title,
// //                         description: description,
// //                         user: "67322ac07b0ef3c99e6a288c",
// //                         videoFile: _selectedVideo!,
// //                       );
// //                     } else {
// //                       print("Veuillez remplir tous les champs et sélectionner une vidéo.");
// //                     }
// //                     // Action du bouton "Post" sans arrière-plan
// //                   },
// //                   child: const Text(
// //                     "Post",
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       color: Color(0xFFFF9228),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:damdleaders_flutter/Controllers/HomeController.dart';
// import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io';
//
// import '../Componets/NotificationLocal.dart';
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
//   final controller = HomeController();
//   File? _selectedVideo;
//   VideoPlayerController? _videoController;
//   final ImagePicker _picker = ImagePicker();
//
//   String? userId;
//   String title = '';
//   String description = '';
//   String? userName;
//   String? userLastName;
//   String? userDomaine;
//   String? photoUrl;
//
//   bool isLoadingUserData = true;
//
//   late final NotificationLocal notificationLocal;
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
//               _videoController!.play();
//             });
//         });
//       }
//     } catch (e) {
//       print("Erreur lors de la sélection de la vidéo : $e");
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }
//
//   Future<void> _loadUserData() async {
//     try {
//       userName = await UserPreference.getName();
//       userLastName = await UserPreference.getLastName();
//       userDomaine = await UserPreference.getDomaine();
//       photoUrl = await UserPreference.getPhotoUrl();
//       userId = await UserPreference.getUserId();
//       print("1111111111111111111111111111111111111111111111111111 $userId");
//     } catch (e) {
//       print("Erreur lors de la récupération des données utilisateur : $e");
//     } finally {
//       setState(() {
//         isLoadingUserData = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isLoadingUserData
//             ? const Center(
//             child: CircularProgressIndicator()) // Affiche un loader
//             : Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   const SizedBox(height: 27.0),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 25,
//                         backgroundImage: photoUrl != null
//                             ? NetworkImage(photoUrl!) // Utiliser NetworkImage pour une URL
//                             : AssetImage('assets/yassineImage.jpg') as ImageProvider, // Image par défaut
//                       ),
//                       const SizedBox(width: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${userName ?? 'Name'} ${userLastName ?? ''}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             userDomaine ?? 'Domaine',
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Post title",
//                     style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         title = value;
//                       });
//                     },
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter title here",
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Description",
//                     style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         description = value;
//                       });
//                     },
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter description here",
//                     ),
//                     maxLines: 4,
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                           Icons.video_library,
//                           color: Color(0xFFFF9228),
//                         ),
//                         onPressed: _pickVideo,
//                       ),
//                       const Text("Add a video"),
//                     ],
//                   ),
//                   if (_selectedVideo != null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       child: SizedBox(
//                         height: 100,
//                         child: _videoController != null &&
//                             _videoController!.value.isInitialized
//                             ? AspectRatio(
//                           aspectRatio:
//                           _videoController!.value.aspectRatio,
//                           child: VideoPlayer(_videoController!),
//                         )
//                             : const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20.0),
//               child: Center(
//                 child: SizedBox(
//                   width: 350,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_selectedVideo != null &&
//                           title.isNotEmpty &&
//                           description.isNotEmpty) {
//
//                         controller.addPost(
//                           title: title,
//                           description: description,
//                           user: userId!,
//                           videoFile: _selectedVideo!,
//                         );
//                       } else {
//                         print(
//                             "Veuillez remplir tous les champs et sélectionner une vidéo.");
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       side: const BorderSide(
//                         color: Color(0xFFFF9228),
//                         width: 2,
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Post",
//                       style: TextStyle(
//                         color: Color(0xFFFF9228),
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//

import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
import 'package:damdleaders_flutter/features/Home/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import '../Componets/NotificationLocal.dart';

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

  String? userId;
  String title = '';
  String description = '';
  String? userName;
  String? userLastName;
  String? userDomaine;
  String? photoUrl;

  bool isLoadingUserData = true;

  late NotificationLocal notificationLocal;

  @override
  void initState() {
    super.initState();
    notificationLocal = NotificationLocal(); // Initialisation de notificationLocal
    _loadUserData();
  }

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

  Future<void> _loadUserData() async {
    try {
      userName = await UserPreference.getName();
      userLastName = await UserPreference.getLastName();
      userDomaine = await UserPreference.getDomaine();
      photoUrl = await UserPreference.getPhotoUrl();
      userId = await UserPreference.getUserId();
      print("1111111111111111111111111111111111111111111111111111 $userId");
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
            ? const Center(child: CircularProgressIndicator()) // Affiche un loader
            : Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 27.0),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: photoUrl != null
                            ? NetworkImage(photoUrl!) // Utiliser NetworkImage pour une URL
                            : const AssetImage('assets/yassineImage.jpg') as ImageProvider, // Image par défaut
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            : const Center(child: CircularProgressIndicator()),
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
                    onPressed: () async {
                      if (_selectedVideo != null &&
                          title.isNotEmpty &&
                          description.isNotEmpty) {

                        // Affichage de la notification de début de l'upload
                        await notificationLocal.showNotification(
                          'upload en cours',
                          'Chargement de la vidéo...',
                          50,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );

                        try {
                          // Envoi de la requête addPost
                          await controller.addPost(
                            title: title,
                            description: description,
                            user: userId!,
                            videoFile: _selectedVideo!,
                          );

                          // Notification de succès après l'upload
                          await notificationLocal.showNotification(
                            'upload success',
                            'Upload réussi!',
                            100,
                          );
                        } catch (e) {
                          // En cas d'erreur lors de l'envoi du post
                          print('Erreur lors de l\'ajout du post: $e');
                          await notificationLocal.showNotification(
                            'upload failed',
                            'Échec de l\'upload',
                            0,
                          );
                        }
                      } else {
                        print("Veuillez remplir tous les champs et sélectionner une vidéo.");
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
