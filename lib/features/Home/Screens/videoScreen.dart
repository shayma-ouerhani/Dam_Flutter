// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import correct pour Obx
// import '../../Widgets/CircleAnimation.dart';
// import '../../Widgets/VideoPlayerItem.dart';
//
// class VideoScreen extends StatelessWidget {
//   VideoScreen({Key? key}) : super(key: key);
//
//   // Exemple de données pour les vidéos (à remplacer par les vraies données)
//   final RxList<String> videos = RxList<String>([
//     'https://res.cloudinary.com/dcjtuxprn/video/upload/v1731524251/UploadLeaders/Enregistrement%20de%20l%27%C3%83%C2%A9cran%202024-07-07%20104521.mp4',
//     'https://res.cloudinary.com/dcjtuxprn/video/upload/v1731524251/UploadLeaders/Enregistrement%20de%20l%27%C3%83%C2%A9cran%202024-07-07%20104521.mp4',
//     'https://res.cloudinary.com/dcjtuxprn/video/upload/v1731524251/UploadLeaders/Enregistrement%20de%20l%27%C3%83%C2%A9cran%202024-07-07%20104521.mp4',
//   ]);
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
//       body: Obx(() {
//         return PageView.builder(
//           controller: PageController(initialPage: 0, viewportFraction: 1),
//           scrollDirection: Axis.vertical,
//           itemCount: videos.length,
//           itemBuilder: (context, index) {
//             final videoUrl = videos[index];
//
//             return Stack(
//               children: [
//                 VideoPlayerItem(videoUrl: videoUrl),
//                 Column(
//                   children: [
//                     const SizedBox(height: 100),
//                     Expanded(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: Container(
//                               padding: const EdgeInsets.only(left: 20),
//                               child: const Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Username",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Caption for the video",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.music_note,
//                                         size: 15,
//                                         color: Colors.white,
//                                       ),
//                                       Text(
//                                         "Audio name",
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 100,
//                             margin: EdgeInsets.only(top: size.height / 5),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 buildProfile("https://example.com/profile.jpg"),
//                                 Column(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         // Action pour "like"
//                                       },
//                                       child: const Icon(
//                                         Icons.favorite,
//                                         size: 40,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 7),
//                                     const Text(
//                                       "100",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         // Navigation vers les commentaires
//                                       },
//                                       child: const Icon(
//                                         Icons.comment,
//                                         size: 40,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 7),
//                                     const Text(
//                                       "50",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         // Action pour "partager"
//                                       },
//                                       child: const Icon(
//                                         Icons.reply,
//                                         size: 40,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 7),
//                                     const Text(
//                                       "20",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 CircleAnimation(
//                                   child: buildMusicAlbum(
//                                       "https://example.com/album.jpg"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import correct pour Obx
import '../../Widgets/CircleAnimation.dart'; // Importez correctement vos widgets
import '../../Widgets/VideoPlayerItem.dart'; // Importez correctement vos widgets

class VideoScreen extends StatelessWidget {
   VideoScreen({super.key});

  final RxList<String> videos = RxList<String>([
    'https://res.cloudinary.com/dcjtuxprn/video/upload/v1731524251/UploadLeaders/Enregistrement%20de%20l%27%C3%83%C2%A9cran%202024-07-07%20104521.mp4',
    'https://res.cloudinary.com/dcjtuxprn/video/upload/v1731524251/UploadLeaders/Enregistrement%20de%20l%27%C3%83%C2%A9cran%202024-07-07%20104521.mp4',
    'https://res.cloudinary.com/dcjtuxprn/video/upload/v1731524251/UploadLeaders/Enregistrement%20de%20l%27%C3%83%C2%A9cran%202024-07-07%20104521.mp4',
  ]);

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
      body: Obx(() {
        return PageView.builder(
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final videoUrl = videos[index];

            return Stack(
              children: [
                VideoPlayerItem(videoUrl: videoUrl),
                Column(
                  children: [
                    const SizedBox(height: 100),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Username",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Caption for the video",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.music_note,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Audio name",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
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
                                buildProfile(
                                    "https://example.com/profile.jpg"),
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
                                    const SizedBox(height: 7),
                                    const Text(
                                      "100",
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
                                    const SizedBox(height: 7),
                                    const Text(
                                      "50",
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
                                    const SizedBox(height: 7),
                                    const Text(
                                      "20",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                CircleAnimation(
                                  child: buildMusicAlbum(
                                      "https://example.com/album.jpg"),
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
      }),
    );
  }
}
