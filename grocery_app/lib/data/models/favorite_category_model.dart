class FavoriteCategoryModel{
  final int id;
  final String name;
  final String photo;

  FavoriteCategoryModel({
    required this.id,
    required this.name,
    required this.photo,
  });

  factory FavoriteCategoryModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCategoryModel(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
    };
  }

  static List<FavoriteCategoryModel> listFromJson(List<dynamic> data) {
    return data.map((e) => FavoriteCategoryModel.fromJson(e)).toList();
  }
}