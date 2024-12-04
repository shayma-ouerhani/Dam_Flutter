// ignore_for_file: prefer_const_constructors

import 'package:damdleaders_flutter/features/Home/Screens/EditProfileView.dart';
import 'package:flutter/material.dart';

class ProfileHomeView extends StatelessWidget {
  const ProfileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( // Added to make the screen scrollable
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min, // Ensure the Row takes minimal space
                mainAxisAlignment: MainAxisAlignment.center, // Center the contents of the Row
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
                mainAxisSize: MainAxisSize.min, // Ensure the Row takes minimal space
                mainAxisAlignment: MainAxisAlignment.center, // Center the contents of the Row
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
              const Row(
                mainAxisSize: MainAxisSize.min, // Ensure the Row takes minimal space
                mainAxisAlignment: MainAxisAlignment.center, // Center the contents of the Row
                children: [
                  Text(
                    "Yassine Ajbouni",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    height: 20, // Set height for the VerticalDivider
                    child: VerticalDivider(
                      width: 20, // Space between the text and the icon
                      thickness: 1, // Thickness of the divider
                      color: Color.fromARGB(255, 14, 13, 13), // Color of the divider
                    ),
                  ),
                  Text(
                    "Flutter Developer",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min, // Ensure the Row takes minimal space
                mainAxisAlignment: MainAxisAlignment.center, // Center the contents of the Row
                children: [
                  const Text("Follow Me @YassineAjbouni"),
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
                              //builder: (context) => ListeCondidat()),
                              builder: (context) => EditProfileView()),
                        );
                      // EditProfileView();
                    },
                    tooltip: 'Edit', // Optional: Tooltip when the user hovers or long-presses
                  ),
                ],
              ),
              const SizedBox(height: 5),
              DefaultTabController(
                length: 2, // Number of tabs
                child: Column(
                  children: [
                    const TabBar(
                      indicatorColor: Colors.blue,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: "Posts"),
                        Tab(text: "Survey"),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child:/* TabBarView(
                        children: [
                          // // Posts Tab
                          ListView.builder(
                            itemCount: 5, // Replace with dynamic count if necessary
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to a new screen with the candidates list
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CandidatesListScreen(postIndex: index + 1),
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
                                              "Post ${index + 1}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Icon(Icons.keyboard_arrow_right,color: Colors.deepOrange,),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Date: ${DateTime.now().toLocal()}",
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Description of the post goes here. This is a placeholder for the post content.",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // Favorites Tab
                          const Center(
                            child: Text(
                              "No favorites available",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                        ],
                      ),*/
                      TabBarView(
  children: [
    // Posts Tab
    ListView.builder(
      itemCount: 5, // Replace with dynamic count if necessary
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CandidatesListScreen(postIndex: index + 1),
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
                        "Post ${index + 1}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right, color: Colors.deepOrange),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Date: ${DateTime.now().toLocal()}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Description of the post goes here. This is a placeholder for the post content.",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    // Survey Tab
    const SurveyWidget(), // Add a new SurveyWidget here
  ],
),

                    ),
                  ],
                ),
              ),
              //const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}










class CandidatesListScreen extends StatelessWidget {
  final int postIndex;

  const CandidatesListScreen({Key? key, required this.postIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example data for candidates
final List<Map<String, String>> candidates = [
  {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'score': '85', // Convert score to String if you need it in textual format
    'image': 'assets/yassineImage.jpg',
  },
  {
    'name': 'Jane Smith',
    'email': 'jane.smith@example.com',
    'score': '90',
    'image': 'assets/yesserImage.png',
  },
  {
    'name': 'Sam Wilson',
    'email': 'sam.wilson@example.com',
    'score': '75',
    'image': 'assets/shaymaImage.jpg',
  },
];


    return Scaffold(
      appBar: AppBar(
        title: Text("Candidates for Post $postIndex"),
      ),
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          final candidate = candidates[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(candidate['image']!),
              ),
              title: Text(candidate['name']!),
              subtitle: Text(candidate['email']!),
              trailing: Text(
                "Score: ${candidate['score']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SurveyWidget extends StatelessWidget {
  const SurveyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example list of survey questions
    final List<String> questions = [
      "What is your favorite programming language?",
      "How many years of experience do you have in Flutter?",
      "What are your thoughts on Dart as a programming language?",
      "Have you used other frameworks besides Flutter? If yes, which ones?",
      "What features do you find most helpful in Flutter?",
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Q${index + 1}: ${questions[index]}",
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
              SizedBox(width: 100,)
            ],
          ),
        ),
      ],
    );
  }
}

