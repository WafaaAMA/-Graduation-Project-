// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_center/Data/repositories/user_repository.dart';
// import 'package:medical_center/Logic/entities/user.dart';
// // import '../../domain/repositories/user_repository.dart';
// // import '../../domain/entities/user.dart';

// class UserCubit extends Cubit<User?> {
//   final UserRepository userRepository;

//   UserCubit(this.userRepository) : super(null);

//   Future<void> fetchUserData() async {
//     try {
//       final user = await userRepository.getUserData();
//       emit(user);
//     } catch (e) {
//       emit(null);
//     }
//   }
// }
