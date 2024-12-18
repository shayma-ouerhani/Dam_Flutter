class Candidat {
  final String id;
  final String photoUrl;
  final double score;
  final String fullName;

  // Constructeur avec les paramètres obligatoires
  Candidat({
    required this.id,
    required this.photoUrl,
    required this.score,
    required this.fullName,
  });

  // Méthode pour créer un objet Candidat à partir d'un Map (JSON)
  factory Candidat.fromJson(Map<String, dynamic> json) {
    return Candidat(
      id: json['id'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      score: json['score']?.toDouble() ?? 0.0,
      fullName: json['fullName'] ?? '',
    );
  }
}
