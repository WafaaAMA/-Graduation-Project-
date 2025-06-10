import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Logic/entities/user.dart';
import '../../Data/repositories/auth_repository.dart';
// import '../../domain/repositories/auth_repository.dart';
// import '../../domain/entities/user.dart';

class AuthCubit extends Cubit<User?> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(null);

  Future<void> login(String email, String password) async {
    final user = await authRepository.login(email, password);
    emit(user);
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(null);
  }
}