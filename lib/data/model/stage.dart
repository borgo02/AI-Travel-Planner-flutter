class Stage {
  String? idStage;
  String name;
  String imageUrl;
  String city;
  String description;
  int position;

  Stage({
    this.idStage,
    required this.name,
    required this.imageUrl,
    required this.city,
    required this.description,
    required this.position,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      idStage: json['idStage'] as String?,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      city: json['city'] as String,
      description: json['description'] as String,
      position: json['position'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idStage': idStage,
      'name': name,
      'imageUrl': imageUrl,
      'city': city,
      'description': description,
      'position': position,
    };
  }
}
