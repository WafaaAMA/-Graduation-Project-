// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_center/Data/repositories/doctor_repository.dart';

// import '../../Logic/entities/doctor.dart';
// // import '../../domain/repositories/doctor_repository.dart';
// // import '../../domain/entities/doctor.dart';

// class DoctorCubit extends Cubit<List<Doctor>> {
//   final DoctorRepository doctorRepository;

//   DoctorCubit(this.doctorRepository) : super([]);

//   Future<void> fetchDoctors() async {
//     try {
//       final doctors = await doctorRepository.getDoctors();
//       emit(doctors);
//     } catch (e) {
//       emit([]);
//     }
//   }
// }