class CategoryModel {
  final int id;
  final String name;
  final String description;
  final String photo;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
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

  static List<CategoryModel> listFromJson(List<dynamic> data) {
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

}