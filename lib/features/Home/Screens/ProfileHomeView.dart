// import 'package:damdleaders_flutter/Controllers/HomeController.dart';
// import 'package:damdleaders_flutter/Models/Post.dart';
// import 'package:damdleaders_flutter/Models/Survey.dart';
// import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
// import 'package:damdleaders_flutter/features/Home/Screens/EditProfileView.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../../Models/Candidat.dart';

// class ProfileHomeView extends StatefulWidget {
//   const ProfileHomeView({super.key});

//   @override
//   _ProfileHomeViewState createState() => _ProfileHomeViewState();
// }

// class _ProfileHomeViewState extends State<ProfileHomeView> {
//   final HomeController postService = HomeController();


//   late Future<List<Post>> mesPosts; // Future for the posts
//   List<Post> allPosts = []; // Store all fetched posts
//   List<Post> filteredPosts = []; // Filtered list for search
//   final TextEditingController searchController = TextEditingController();

//   // Variables pour stocker les informations utilisateur
//   String? userName;
//   String? userLastName;
//   String? userDomaine;

//   bool isLoadingUserData = true; // Indicateur de chargement

//   @override
//   void initState() {
//     super.initState();
//      _loadUserData(); // Charger les données utilisateur
//     // Initialize the Future
//     mesPosts = postService.fetchMyPosts("674cabd54603d2eeb31c56e3");

//     mesPosts.then((posts) {
//       setState(() {
//         allPosts = posts; // Store all posts
//         filteredPosts =
//             posts; // Initially, the filtered list equals the full list
//       });
//     });
//   }

//   Future<void> _loadUserData() async {
//     try {
//       userName = await UserPreference.getName() as String?;
//       userLastName = await UserPreference.getLastName() as String?;
//       userDomaine = await UserPreference.getDomaine() as String?;
//     } catch (e) {
//       print("Erreur lors de la récupération des données utilisateur : $e");
//     } finally {
//       setState(() {
//         isLoadingUserData = false; // Fin du chargement
//       });
//     }
//   }

//   void filterPosts(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredPosts = List.from(allPosts);
//       } else {
//         filteredPosts = allPosts.where((post) {
//           final title = post.title?.toLowerCase() ?? "";
//           final date = _formatDate(post.createdAt);
//           final searchQuery = query.toLowerCase();
//           return title.contains(searchQuery) ||
//               date.toLowerCase().contains(searchQuery);
//         }).toList();
//       }
//     });
//   }

//   String _formatDate(String? dateString) {
//     if (dateString == null || dateString.isEmpty) {
//       return "No date";
//     }
//     try {
//       // Convertir la chaîne en DateTime
//       DateTime parsedDate = DateTime.parse(dateString);

//       // Formater la date (par exemple, "dd MMM yyyy")
//       return DateFormat('dd MMM yyyy').format(parsedDate);
//     } catch (e) {
//       return "Invalid date"; // En cas d'erreur dans le formatage
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "${userName ?? 'Name'} ${userLastName ?? 'Last Name'}",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     onPressed: () {
//                       // Action for the icon button
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         "0",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text("Followers"),
//                     ],
//                   ),
//                   SizedBox(width: 15),
//                   CircleAvatar(
//                     radius: 35,
//                     backgroundImage: AssetImage('assets/yassineImage.jpg'),
//                   ),
//                   SizedBox(width: 15),
//                   Column(
//                     children: [
//                       Text(
//                         "0",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text("Following"),
//                     ],
//                   ),
//                 ],
//               ),
//               const Divider(),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "${userName ?? 'Name'} ${userLastName ?? 'Last Name'}",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 8),
//                   const SizedBox(
//                     height: 20,
//                     child: VerticalDivider(
//                       width: 20,
//                       thickness: 1,
//                       color: Color.fromARGB(255, 14, 13, 13),
//                     ),
//                   ),
//                   const SizedBox(width: 8), // Ajouté pour l'espacement
//                   Text(
//                     "${userDomaine ?? 'Domaine'}",
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 8), // Ajouté pour l'espacement
//                   IconButton(
//                     icon: const Icon(
//                       Icons.edit,
//                       size: 16,
//                       color: Colors.yellow,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EditProfileView(),
//                         ),
//                       );
//                     },
//                     tooltip: 'Edit',
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 5),
//               // Profile information and search bar
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextField(
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search),
//                     hintText: "Search by title or date...",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   onChanged: (query) {
//                     filterPosts(query); // Filter the posts based on input
//                   },
//                 ),
//               ),
//               const SizedBox(height: 10),
//               FutureBuilder<List<Post>>(
//                 future: mesPosts,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text("Error fetching posts: ${snapshot.error}"),
//                     );
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text("No posts found."));
//                   } else {
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: filteredPosts.length,
//                       itemBuilder: (context, index) {
//                         final post = filteredPosts[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CandidatesListScreen(
//                                   postIndex: index,
//                                   postTitle: post.title ?? "No Title",
//                                   postId: post.id ?? "", // Pass the postId here
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Card(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         post.title ?? "No Title",
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const Icon(Icons.keyboard_arrow_right,
//                                           color: Colors.deepOrange),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   // Text(
//                                   //   "Date: ${post.createdAt ?? "No date"}",
//                                   //   style: const TextStyle(color: Colors.grey),
//                                   // ),
//                                   Text(
//                                     "Date: ${_formatDate(post.createdAt)}",
//                                     style: const TextStyle(color: Colors.grey),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     post.content ?? "No description",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CandidatesListScreen extends StatefulWidget {
//   final int postIndex; // Accept postIndex as a parameter
//   final String postTitle; // Accept postTitle as a parameter
//   final String postId; // Accept postId as a parameter to fetch candidates

//   const CandidatesListScreen({
//     Key? key,
//     required this.postIndex,
//     required this.postTitle,
//     required this.postId, // Pass postId to the screen
//   }) : super(key: key);

//   @override
//   _CandidatesListScreenState createState() => _CandidatesListScreenState();
// }

// class _CandidatesListScreenState extends State<CandidatesListScreen> {
//   final HomeController postService = HomeController();
//   late Future<List<Candidat>> candidates; // Future for the candidates

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the candidates for the given post ID
//     candidates = postService.fetchCandidatesByPost(widget.postId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${widget.postTitle}"),
//       ),
//       body: DefaultTabController(
//         length: 2, // Number of tabs
//         child: Column(
//           children: [
//             // const TabBar(
//             //   indicatorColor: Colors.blue,
//             //   labelColor: Colors.black,
//             //   unselectedLabelColor: Colors.grey,
//             //   tabs: [
//             //     Tab(text: "Candidates"),
//             //     Tab(text: "Survey"),
//             //   ],
//             // ),
//             TabBar(
//   indicatorColor: Colors.blue,
//   labelColor: Colors.black,
//   unselectedLabelColor: Colors.grey,
//   tabs: [
//     Tab(text: "Candidates"),
//     Tab(
//       child: Row(
//         mainAxisSize: MainAxisSize.min, // Ensures the row takes only the required space
//         children: [
//           Text("Survey"), // Text
//           SizedBox(width: 8), // Space between text and image
//           Image.asset("assets/ai.png", height: 25, width: 25),
//         ],
//       ),
//     ),
//   ],
// ),

//             Expanded(
//               child: TabBarView(
//                 children: [
//                   // Candidates Tab
//                   FutureBuilder<List<Candidat>>(
//                     future: candidates,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Center(
//                           child: Text("Error fetching candidates: ${snapshot.error}"),
//                         );
//                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                         return const Center(child: Text("No candidates found."));
//                       } else {
//                         return ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             final candidate = snapshot.data![index];
//                             return Card(
//                               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               child: ListTile(
//                                 leading: CircleAvatar(
//                                   backgroundImage: NetworkImage(candidate.photoUrl),
//                                 ),
//                                 title: Text(candidate.fullName),
//                                 subtitle: Text(candidate.id), // You can show more details here
//                                 trailing: Text(
//                                   "Score: ${candidate.score}",
//                                   style: const TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//                   // Survey Tab
//                   //const SurveyWidget(),
//                   const SurveyWidgetScreen(postId: "676063c975d37351bf618e0b")
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class SurveyWidgetScreen extends StatefulWidget {
//   final String postId; // Accept postId as a parameter to fetch survey

//   const SurveyWidgetScreen({
//     Key? key,
//     required this.postId, // Pass postId to the screen
//   }) : super(key: key);

//   @override
//   _SurveyWidgetScreenState createState() => _SurveyWidgetScreenState();
// }

// class _SurveyWidgetScreenState extends State<SurveyWidgetScreen> {
//   final HomeController postService = HomeController();
//   late Future<Survey> survey;

//   // List of TextEditingControllers to store user input
//   List<TextEditingController> answerControllers = [];

//   @override
//   void initState() {
//     super.initState();
//     survey = postService.fetchSurveyByPost(widget.postId);
//   }

//   @override
//   void dispose() {
//     // Dispose controllers to avoid memory leaks
//     for (var controller in answerControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<Survey>(
//         future: survey,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Error: ${snapshot.error}"),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         survey = postService.fetchSurveyByPost(widget.postId);
//                       });
//                     },
//                     child: const Text("Retry"),
//                   ),
//                 ],
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.questions.isEmpty) {
//             return const Center(child: Text("No questions available."));
//           } else {
//             final surveyData = snapshot.data!;
//             answerControllers = List.generate(
//               surveyData.questions.length,
//               (index) => TextEditingController(
//                 text: "Q${index + 1}: ${surveyData.questions[index]}"
//               ),
//             );



//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: surveyData.questions.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // User Input Field
//                               TextField(
//                                 controller: answerControllers[index],
//                                 maxLines: null, // Allows the field to grow dynamically with content
//                                 keyboardType: TextInputType.multiline, // Enables multiline keyboard on mobile
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),


//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Collect user answers
//                       List<String> userAnswers = answerControllers
//                           .map((controller) => controller.text.trim()) // Trim whitespace
//                           .toList();

//                       // Check for empty answers
//                       if (userAnswers.any((answer) => answer.isEmpty)) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Please answer all questions before submitting."),
//                             backgroundColor: Colors.red, // Error color
//                           ),
//                         );
//                       } else {
//                         // Print answers and show success message
//                         print("User Answers: $userAnswers");

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Survey submitted successfully!"),
//                           ),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 48, 0, 131),
//                       minimumSize: const Size(350, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(
//                         color: Colors.white, // Set text color to white
//                         fontSize: 16,        // Optional: Adjust font size
//                         fontWeight: FontWeight.bold, // Optional: Make it bold
//                       ),
//                     ),
//                       ),
//                     ),

//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:damdleaders_flutter/Models/Post.dart';
import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Models/Candidat.dart';
import '../../../Models/Survey.dart';
import 'EditProfileView.dart';

class ProfileHomeView extends StatefulWidget {
  const ProfileHomeView({super.key});

  @override
  _ProfileHomeViewState createState() => _ProfileHomeViewState();
}

class _ProfileHomeViewState extends State<ProfileHomeView> {
  final HomeController postService = HomeController();

  late Future<List<Post>> mesPosts; // Future for the posts
  List<Post> allPosts = []; // Store all fetched posts
  List<Post> filteredPosts = []; // Filtered list for search
  final TextEditingController searchController = TextEditingController();

  // Variables pour stocker les informations utilisateur
  String? userName;
  String? userLastName;
  String? userDomaine;
  String? userId;
  String? photoUrl;

  bool isLoadingUserData = true; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Charger les données utilisateur
  }

  Future<void> _loadUserData() async {
    try {
      userName = await UserPreference.getName();
      userLastName = await UserPreference.getLastName();
      userDomaine = await UserPreference.getDomaine();
      userId = await UserPreference.getUserId();
      photoUrl = await UserPreference.getPhotoUrl();
      print(photoUrl);
      print("****************************************************************************************-*********************************************************************************************");
      mesPosts = postService.fetchMyPosts(userId!);

      // Attend la récupération des posts
      mesPosts.then((posts) {
        setState(() {
          allPosts = posts;
          filteredPosts = posts; // Initial filtered posts list
        });
      });
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur : $e");
    } finally {
      setState(() {
        isLoadingUserData = false;
      });
    }
  }

  void filterPosts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPosts = List.from(allPosts); // Reset to all posts
      } else {
        filteredPosts = allPosts.where((post) {
          final title = post.title?.toLowerCase() ?? "";
          final date = _formatDate(post.createdAt);
          final searchQuery = query.toLowerCase();
          return title.contains(searchQuery) ||
              date.toLowerCase().contains(searchQuery);
        }).toList();
      }
    });
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "No date";
    }
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${userName ?? 'Name'} ${userLastName ?? 'Last Name'}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    children: [
                      Text(
                        "0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text("Followers"),
                    ],
                  ),
                  const SizedBox(width: 15),
                  /*CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/yassineImage.jpg'),
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

                  const SizedBox(width: 15),
                  const Column(
                    children: [
                      Text(
                        "0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text("Following"),
                    ],
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${userName ?? 'Name'} ${userLastName ?? 'Last Name'}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      width: 20,
                      thickness: 1,
                      color: Color.fromARGB(255, 14, 13, 13),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${userDomaine ?? 'Domaine'}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  EditProfileView(),
                        ),
                      );
                    },
                    tooltip: 'Edit',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search by title or date...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: filterPosts,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Post>>(
                future: mesPosts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error fetching posts: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No posts found."));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post = filteredPosts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CandidatesListScreen(
                                  postIndex: index,
                                  postTitle: post.title ?? "No Title",
                                  postId: post.id ?? "",
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        post.title ?? "No Title",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_right,
                                          color: Colors.deepOrange),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Date: ${_formatDate(post.createdAt)}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    post.content ?? "No description",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CandidatesListScreen extends StatefulWidget {
  final int postIndex;
  final String postTitle;
  final String postId;

  const CandidatesListScreen({
    Key? key,
    required this.postIndex,
    required this.postTitle,
    required this.postId,
  }) : super(key: key);

  @override
  _CandidatesListScreenState createState() => _CandidatesListScreenState();
}

class _CandidatesListScreenState extends State<CandidatesListScreen> {
  final HomeController postService = HomeController();
  late Future<List<Candidat>> candidates;

  @override
  void initState() {
    super.initState();
    candidates = postService.fetchCandidatesByPost(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postTitle),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                const Tab(text: "Candidates"),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Survey"),
                      const SizedBox(width: 8),
                      Image.asset("assets/ai.png", height: 25, width: 25),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder<List<Candidat>>(
                    future: candidates,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                              "Error fetching candidates: ${snapshot.error}"),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No candidates found."));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final candidate = snapshot.data![index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      candidate.photoUrl),
                                ),
                                title: Text(candidate.fullName),
                                subtitle: Text(candidate.id),
                                trailing: Text(
                                  "Score: ${candidate.score}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SurveyWidgetScreen(postId: "67473b53c040db940a58ed2d"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SurveyWidgetScreen extends StatefulWidget {
  final String postId;

  const SurveyWidgetScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  _SurveyWidgetScreenState createState() => _SurveyWidgetScreenState();
}

class _SurveyWidgetScreenState extends State<SurveyWidgetScreen> {
  final HomeController postService = HomeController();
  late Future<Survey> survey;

  List<TextEditingController> answerControllers = [];

  @override
  void initState() {
    super.initState();
    survey = postService.fetchSurveyByPost(widget.postId);
  }

  @override
  void dispose() {
    for (var controller in answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Survey>(
      future: survey,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error: ${snapshot.error}"),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      survey = postService.fetchSurveyByPost(widget.postId);
                    });
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.questions.isEmpty) {
          return const Center(child: Text("No survey questions available."));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.questions.length,
            itemBuilder: (context, index) {
              var question = snapshot.data!.questions[index];
              answerControllers.add(TextEditingController());
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question),
                    TextField(
                      controller: answerControllers[index],
                      decoration: const InputDecoration(hintText: "Answer"),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}