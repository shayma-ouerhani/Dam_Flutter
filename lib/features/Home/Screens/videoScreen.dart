//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import correct pour Obx
// import '../../../Controllers/HomeController.dart';
// import '../../../Models/Post.dart';
// import '../../Widgets/VideoPlayerItem.dart'; // Importez correctement vos widgets
//
// class VideoScreen extends StatefulWidget {
//   VideoScreen({Key? key}) : super(key: key);
//
//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   final HomeController postService = HomeController();
//   late Future<List<Post>> futurePosts;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialisation de futurePosts
//     futurePosts = postService.fetchVideos();
//   }
//
//   Widget buildProfile(String profilePhoto) {
//     return SizedBox(
//       width: 60,
//       height: 60,
//       child: Stack(
//         children: [
//           Positioned(
//             left: 5,
//             child: Container(
//               width: 50,
//               height: 50,
//               padding: const EdgeInsets.all(1),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(25),
//                 child: Image.network(
//                   profilePhoto,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                   const Icon(Icons.person, size: 50),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget buildMusicAlbum(String profilePhoto) {
//     return SizedBox(
//       width: 60,
//       height: 60,
//       child: Container(
//         padding: const EdgeInsets.all(11),
//         height: 50,
//         width: 50,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Colors.grey,
//               Colors.white,
//             ],
//           ),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(25),
//           child: Image.network(
//             profilePhoto,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) =>
//             const Icon(Icons.music_note, size: 50),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: FutureBuilder<List<Post>>(
//         future: futurePosts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final posts = snapshot.data!;
//             return PageView.builder(
//               controller: PageController(initialPage: 0, viewportFraction: 1),
//               scrollDirection: Axis.vertical,
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 final videoUrl = posts[index].videoUrl; // Utilisation de videoUrl depuis Post
//
//                 return Stack(
//                   children: [
//                     VideoPlayerItem(videoUrl: videoUrl.toString()),
//                     Column(
//                       children: [
//                         const SizedBox(height: 100),
//                         Expanded(
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   padding: const EdgeInsets.only(left: 2, bottom: 5),
//                                   child: const Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         "Username",
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Text(
//                                         "Caption for the video",
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.music_note,
//                                             size: 15,
//                                             color: Colors.white,
//                                           ),
//                                           Text(
//                                             "Audio name",
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 width: 100,
//                                 margin: EdgeInsets.only(top: size.height / 5),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     buildProfile("https://example.com/profile.jpg"),
//                                     Column(
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             // Action pour "like"
//                                           },
//                                           child: const Icon(
//                                             Icons.favorite,
//                                             size: 40,
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 7),
//                                         const Text(
//                                           "100",
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             color: Colors.white,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     Column(
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             // Navigation vers les commentaires
//                                           },
//                                           child: const Icon(
//                                             Icons.comment,
//                                             size: 40,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 7),
//                                         const Text(
//                                           "50",
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             color: Colors.white,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     Column(
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             // Action pour "partager"
//                                           },
//                                           child: const Icon(
//                                             Icons.reply,
//                                             size: 40,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 7),
//                                         const Text(
//                                           "20",
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             color: Colors.white,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text('No data available'));
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import correct pour Obx
import '../../../Controllers/HomeController.dart';
import '../../../Models/Post.dart';
import '../../Widgets/VideoPlayerItem.dart'; // Importez correctement vos widgets

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final HomeController postService = HomeController();
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    // Initialisation de futurePosts
    futurePosts = postService.fetchVideos();
  }

  Widget buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  profilePhoto,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.person, size: 50),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Container(
        padding: const EdgeInsets.all(11),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.grey,
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            profilePhoto,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.music_note, size: 50),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return PageView.builder(
              controller: PageController(initialPage: 0, viewportFraction: 1),
              scrollDirection: Axis.vertical,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final videoUrl = posts[index].videoUrl; // Utilisation de videoUrl depuis Post

                return Stack(
                  children: [
                    VideoPlayerItem(videoUrl: videoUrl.toString()),
                    Column(
                      children: [
                        const SizedBox(height: 100),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 2, bottom: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        posts[index].userName, // Dynamique: nom d'utilisateur
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        posts[index].content.length > 50
                                            ? posts[index].content.substring(0, 50) + '...' // Troncature avec "..."
                                            : posts[index].content, // Affichage complet si inférieur à 50 caractères
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),

                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.music_note,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            posts[index].title, // Dynamique: titre de la musique ou audio
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                margin: EdgeInsets.only(top: size.height / 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildProfile(posts[index].photoUrl), // Dynamique: photo de profil
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Action pour "like"
                                          },
                                          child: const Icon(
                                            Icons.favorite,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                        ),
                                        // const SizedBox(height: 7),
                                        Text(
                                          posts[index].nbLikes.toString(), // Dynamique: nombre de likes
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Navigation vers les commentaires
                                          },
                                          child: const Icon(
                                            Icons.comment,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        // const SizedBox(height: 7),
                                        Text(
                                          posts[index].commentaires.length.toString(), // Dynamique: nombre de commentaires
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Action pour "partager"
                                          },
                                          child: const Icon(
                                            Icons.reply,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        // const SizedBox(height: 7),
                                        const Text(
                                          "20", // Exemple statique de nombre de partages
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
