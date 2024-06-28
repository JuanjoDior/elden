class Boss {
  final String id;
  final String name;
  final String image;
  final String description;
  final String location;
  final List<String> drops;
  final String healthPoints;

  Boss({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.location,
    required this.drops,
    required this.healthPoints,
  });

  factory Boss.fromJson(Map<String, dynamic> json) {
    return Boss(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Sin nombre',
      image: json['image'] ?? '',
      description: json['description'] ?? 'Sin descripción',
      location: json['location'] ?? 'Ubicación desconocida',
      drops: (json['drops'] != null) ? List<String>.from(json['drops']) : [],
      healthPoints: json['healthPoints'] ?? 'Desconocido',
    );
  }
}
