// import 'package:medical_center/Core/api/api_consumer.dart';
// import 'package:medical_center/Core/api/endpoints.dart';
// import 'package:medical_center/Data/models/doctor_model.dart';

// class DoctorRepository {
//   final ApiConsumer apiConsumer;

//   DoctorRepository({required this.apiConsumer});

//   Future<List<DoctorModel>> getDoctors() async {
//     try {
//       print('Fetching all doctors from API');
//       final response = await apiConsumer.get(Endpoints.getAllDoctors);
//       if (response is List) {
//         return response.map((json) => DoctorModel.fromJson(json)).toList();
//       } else {
//         print('Unexpected response format: $response');
//         throw Exception('API response is not a list');
//       }
//     } catch (e) {
//       print('Error fetching doctors: $e');
//       rethrow;
//     }
//   }

//   Future<List<DoctorModel>> getDoctorsByDepartment(String department) async {
//     try {
//       print('Fetching doctors for department: $department');
//       final response = await apiConsumer.get(Endpoints.getDoctorsByDepartment(department));
//       if (response is List) {
//         return response.map((json) => DoctorModel.fromJson(json)).toList();
//       } else {
//         print('Unexpected response format: $response');
//         throw Exception('API response is not a list');
//       }
//     } catch (e) {
//       print('Error fetching doctors by department: $e');
//       rethrow;
//     }
//   }

//   Future<DoctorModel> getDoctorById(String id) async {
//     try {
//       print('Fetching doctor with ID: $id');
//       final response = await apiConsumer.get(Endpoints.getDoctorById(id));
//       return DoctorModel.fromJson(response);
//     } catch (e) {
//       print('Error fetching doctor by ID: $e');
//       rethrow;
//     }
//   }
// }