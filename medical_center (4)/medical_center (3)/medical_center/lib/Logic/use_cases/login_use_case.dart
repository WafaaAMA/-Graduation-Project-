// domain/use_cases/login_use_case.dart
// import '../repositories/auth_repository.dart';
import 'package:medical_center/Data/repositories/auth_repository.dart';

import '../entities/user.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<User> execute(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
