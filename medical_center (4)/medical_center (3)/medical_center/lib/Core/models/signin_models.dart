import 'package:medical_center/Core/api/endpoints.dart';

class SigninModel {
  final String token;

  SigninModel({required this.token});

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(token: json[ApiKey.token]);
  }
}