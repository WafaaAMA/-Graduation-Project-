// domain/repositories/auth_repository.dart
import 'package:medical_center/Logic/entities/user.dart';

// import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> register(String name, String email, String password);
  Future<void> logout();
}
