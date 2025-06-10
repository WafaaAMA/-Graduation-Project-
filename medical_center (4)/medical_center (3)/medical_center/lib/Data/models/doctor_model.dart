class DoctorModel {
  final String id;
  final String name;
  final String? departmentName;
  final String? info;
  final double? rating;

  DoctorModel({
    required this.id,
    required this.name,
    this.departmentName,
    this.info,
    this.rating,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    if (id == null || id.isEmpty) {
      print('DoctorModel: Error - Invalid or missing ID in JSON: $json');
      return DoctorModel(
        id: 'INVALID_ID_${DateTime.now().millisecondsSinceEpoch}',
        name: json['name'] ?? 'Unknown',
        departmentName: json['departmentName'],
        info: json['info'],
        rating: (json['rating'] as num?)?.toDouble(),
      );
    }
    return DoctorModel(
      id: id,
      name: json['name'] ?? 'Unknown',
      departmentName: json['departmentName'],
      info: json['info'],
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'departmentName': departmentName,
      'info': info,
      'rating': rating,
    };
  }
}