// class NurseModel {
//   final String? id;
//   final String name;
//   final String? departmentName;
//   final String? info;
//   final double? rating;

//   NurseModel({
//     this.id,
//     required this.name,
//     this.departmentName,
//     this.info,
//     this.rating,
//   });

//   factory NurseModel.fromJson(Map<String, dynamic> json) {
//     return NurseModel(
//       id: json['id']?.toString(),
//       name: json['name'] ?? 'Unknown',
//       departmentName: json['departmentName'],
//       info: json['info'],
//       rating: (json['rating'] as num?)?.toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'departmentName': departmentName,
//       'info': info,
//       'rating': rating,
//     };
//   }
// }