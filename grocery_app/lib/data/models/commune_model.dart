class CommuneModel {
  final int id;
  final String name;

  CommuneModel({
    required this.id,
    required this.name,
  });

  factory CommuneModel.fromJson(Map<String, dynamic> json) {
    return CommuneModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<CommuneModel> listFromJson(List<dynamic> data) {
    return data.map((e) => CommuneModel.fromJson(e)).toList();
  }

}