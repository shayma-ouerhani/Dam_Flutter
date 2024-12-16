import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:damdleaders_flutter/Models/Post.dart';
import 'package:damdleaders_flutter/Models/Survey.dart';
import 'package:damdleaders_flutter/features/Home/Screens/EditProfileView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Models/Candidat.dart';

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

  @override
  void initState() {
    super.initState();
    // Initialize the Future
    mesPosts = postService.fetchMyPosts("674cabd54603d2eeb31c56e3");

    mesPosts.then((posts) {
      setState(() {
        allPosts = posts; // Store all posts
        filteredPosts = posts; // Initially, the filtered list equals the full list
      });
    });
  }

void filterPosts(String query) {
  setState(() {
    if (query.isEmpty) {
      filteredPosts = List.from(allPosts); // Réinitialise la liste filtrée
    } else {
      filteredPosts = allPosts.where((post) {
        final title = post.title?.toLowerCase() ?? ""; // Titre du post
        final date = _formatDate(post.createdAt); // Date formatée
        final searchQuery = query.toLowerCase(); // Requête en minuscule

        // Vérifie si le titre ou la date contient la requête
        return title.contains(searchQuery) || date.toLowerCase().contains(searchQuery);
      }).toList();
    }
  });
}

String _formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return "No date";
  }
  try {
    // Convertir la chaîne en DateTime
    DateTime parsedDate = DateTime.parse(dateString);

    // Formater la date (par exemple, "dd MMM yyyy")
    return DateFormat('dd MMM yyyy').format(parsedDate);
  } catch (e) {
    return "Invalid date"; // En cas d'erreur dans le formatage
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
                  const Text(
                    "Yassine Ajbouni",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      // Action for the icon button
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "100K",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text("Followers"),
                    ],
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/yassineImage.jpg'),
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Text(
                        "23.5K",
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
                  const Text(
                    "Yassine Ajbouni",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  const Text(
                    "Flutter Developer",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
                          builder: (context) => EditProfileView(),
                        ),
                      );
                    },
                    tooltip: 'Edit',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // Profile information and search bar
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
                  onChanged: (query) {
                    filterPosts(query); // Filter the posts based on input
                  },
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
                                  postId: post.id ?? "", // Pass the postId here
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        post.title ?? "No Title",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_right, color: Colors.deepOrange),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Text(
                                  //   "Date: ${post.createdAt ?? "No date"}",
                                  //   style: const TextStyle(color: Colors.grey),
                                  // ),
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
  final int postIndex; // Accept postIndex as a parameter
  final String postTitle; // Accept postTitle as a parameter
  final String postId; // Accept postId as a parameter to fetch candidates

  const CandidatesListScreen({
    Key? key,
    required this.postIndex,
    required this.postTitle,
    required this.postId, // Pass postId to the screen
  }) : super(key: key);

  @override
  _CandidatesListScreenState createState() => _CandidatesListScreenState();
}

class _CandidatesListScreenState extends State<CandidatesListScreen> {
  final HomeController postService = HomeController();
  late Future<List<Candidat>> candidates; // Future for the candidates

  @override
  void initState() {
    super.initState();
    // Fetch the candidates for the given post ID
    candidates = postService.fetchCandidatesByPost(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.postTitle}"),
      ),
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Column(
          children: [
            const TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Candidates"),
                Tab(text: "Survey"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Candidates Tab
                  FutureBuilder<List<Candidat>>(
                    future: candidates,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error fetching candidates: ${snapshot.error}"),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No candidates found."));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final candidate = snapshot.data![index];
                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(candidate.photoUrl),
                                ),
                                title: Text(candidate.fullName),
                                subtitle: Text(candidate.id), // You can show more details here
                                trailing: Text(
                                  "Score: ${candidate.score}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  // Survey Tab
                  //const SurveyWidget(),
                  const SurveyWidgetScreen(postId: "some_post_id_here")
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
  final String postId; // Accept postId as a parameter to fetch survey

  const SurveyWidgetScreen({
    Key? key,
    required this.postId, // Pass postId to the screen
  }) : super(key: key);

  @override
  _SurveyWidgetScreenState createState() => _SurveyWidgetScreenState();
}

class _SurveyWidgetScreenState extends State<SurveyWidgetScreen> {
  final HomeController postService = HomeController();
  // Declare a Future to fetch the survey
  late Future<Survey> survey;

  @override
  void initState() {
    super.initState();
    // Initialize the Future to fetch survey data
    survey = postService.fetchSurveyByPost(widget.postId);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Survey>(
        future: survey, // Fetch the survey based on the postId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.questions.isEmpty) {
            return const Center(child: Text("No questions available."));
          } else {
            final survey = snapshot.data!; // The fetched survey

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: survey.questions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Q${index + 1}: ${survey.questions[index]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Survey submitted!"),
                            ),
                          );
                        },
                        child: const Text("Submit"),
                      ),
                      const SizedBox(width: 100),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
