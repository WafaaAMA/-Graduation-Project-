class UserModel {
  final String name;
  final String email;
  final String phone;
  final int gender;
  final int age;
  final String? profilePictureUrl;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.age,
    this.profilePictureUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phoneNumber"] ?? "",
      gender: json["gender"] ?? 1,
      age: json["age"] ?? 0,
      profilePictureUrl: json["profilePictureUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phone,
      "gender": gender,
      "age": age,
      "profilePictureUrl": profilePictureUrl,
    };
  }
}