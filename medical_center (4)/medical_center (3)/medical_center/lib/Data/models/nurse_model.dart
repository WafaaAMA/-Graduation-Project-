class NurseModel {
  final String id;
  final String name;
  final String? departmentName;
  final String? specialization;
  final String? info;
  final double? rating;

  NurseModel({
    required this.id,
    required this.name,
    this.departmentName,
    this.specialization,
    this.info,
    this.rating,
  });

  factory NurseModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    if (id == null || id.isEmpty) {
      print('NurseModel: Error - Invalid or missing ID in JSON: $json');
      return NurseModel(
        id: 'INVALID_ID_${DateTime.now().millisecondsSinceEpoch}',
        name: json['name'] ?? 'Unknown',
        departmentName: json['departmentName'],
        specialization: json['specialization'],
        info: json['info'],
        rating: (json['rating'] as num?)?.toDouble(),
      );
    }
    return NurseModel(
      id: id,
      name: json['name'] ?? 'Unknown',
      departmentName: json['departmentName'],
      specialization: json['specialization'],
      info: json['info'],
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'departmentName': departmentName,
      'specialization': specialization,
      'info': info,
      'rating': rating,
    };
  }
}