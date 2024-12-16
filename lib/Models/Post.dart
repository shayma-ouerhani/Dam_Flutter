// class Post {
//   final String id;
//   final String title;
//   final String content;
//   final List<String> videos;
//   final String type;
//   final List<dynamic> commentaires;
//   final int nbLikes;
//   final String? user;
//   final String createdAt;
//   final String updatedAt;
//   final String userName;
//   final String photoUrl;
//   final String? videoUrl;

//   Post({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.videos,
//     required this.type,
//     required this.commentaires,
//     required this.nbLikes,
//     this.user,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.userName,
//     required this.photoUrl,
//     this.videoUrl,
//   });

//   // Méthode pour convertir un JSON en objet Post
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['_id'],
//       title: json['title'],
//       content: json['content'],
//       videos: List<String>.from(json['videos']),
//       type: json['type'],
//       commentaires: List<dynamic>.from(json['commentaires']),
//       nbLikes: json['nbLikes'],
//       user: json['user'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       userName: json['userName'] ?? '',
//       photoUrl: json['photoUrl'] ?? '',
//       videoUrl: json['videoUrl'],
//     );
//   }

//   // Méthode pour convertir un objet Post en JSON
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'title': title,
//       'content': content,
//       'videos': videos,
//       'type': type,
//       'commentaires': commentaires,
//       'nbLikes': nbLikes,
//       'user': user,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'userName': userName,
//       'photoUrl': photoUrl,
//       'videoUrl': videoUrl,
//     };
//   }


// }
class Post {
  final String id;
  final String title;
  final String content;
  final List<String> videos;
  final String type;
  final List<dynamic> commentaires;
  final int nbLikes;
  final String? user;
  final String createdAt;
  final String updatedAt;
  final String userName;
  final String photoUrl;
  final String? videoUrl;
  final List<String> survey; // Added survey property

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.videos,
    required this.type,
    required this.commentaires,
    required this.nbLikes,
    this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.photoUrl,
    this.videoUrl,
    required this.survey, // Initialize survey
  });

  // Convert JSON to Post object
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      videos: List<String>.from(json['videos']),
      type: json['type'],
      commentaires: List<dynamic>.from(json['commentaires']),
      nbLikes: json['nbLikes'],
      user: json['user'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userName: json['userName'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      videoUrl: json['videoUrl'],
      survey: json['survey'] is List ? List<String>.from(json['survey']) : [],
      //survey: List<String>.from(json['survey'] ?? []), // Ensure it's a list of strings
    );
  }

  // Convert Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'videos': videos,
      'type': type,
      'commentaires': commentaires,
      'nbLikes': nbLikes,
      'user': user,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userName': userName,
      'photoUrl': photoUrl,
      'videoUrl': videoUrl,
      'survey': survey, // Include survey in JSON
    };
  }
}
