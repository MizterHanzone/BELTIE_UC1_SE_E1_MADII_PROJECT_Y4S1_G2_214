class BrandModel {
  final int id;
  final String name;
  final String description;
  final String photo;

  BrandModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        photo: json['photo']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photo': photo,
    };
  }

  static List<BrandModel> listFromJson(List<dynamic> data) {
    return data.map((e) => BrandModel.fromJson(e)).toList();
  }
}