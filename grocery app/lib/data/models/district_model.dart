class DistrictModel {
  final int id;
  final String name;

  DistrictModel({
    required this.id,
    required this.name,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
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

  static List<DistrictModel> listFromJson(List<dynamic> data) {
    return data.map((e) => DistrictModel.fromJson(e)).toList();
  }

}