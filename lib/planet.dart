class Planet {
  final String name;
  final String description;
  final String image;
  final List<String> funFacts;

  Planet({
    required this.name,
    required this.description,
    required this.image,
    required this.funFacts,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      funFacts: List<String>.from(json['funFacts']),
    );
  }
}
