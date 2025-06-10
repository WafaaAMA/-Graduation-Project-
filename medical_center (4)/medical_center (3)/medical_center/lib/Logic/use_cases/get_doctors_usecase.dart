// import '../repositories/doctor_repository.dart';
import 'package:medical_center/Logic/repositories/doctoe_repository.dart';

import '../entities/doctor.dart';

class GetDoctorsUseCase {
  final DoctorRepository doctorRepository;

  GetDoctorsUseCase(this.doctorRepository);

  Future<List<Doctor>> execute() async {
    return await doctorRepository.getDoctors();
  }
}