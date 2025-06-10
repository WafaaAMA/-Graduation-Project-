import 'package:medical_center/Core/api/api_consumer.dart';
import 'package:medical_center/Core/api/endpoints.dart';
import 'package:medical_center/Data/models/doctor_model.dart';
import 'package:medical_center/Data/models/nurse_model.dart';

// Service class for handling booking-related API calls
class BookingService {
  final ApiConsumer apiConsumer;

  BookingService({required this.apiConsumer});

  // Books a doctor with the given ID
  Future<Map<String, dynamic>> bookDoctor({
    required String doctorId,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      print('BookingService: Attempting to book doctor with ID: $doctorId');
      final response = await apiConsumer.post(
        Endpoints.bookDoctor(doctorId),
        data: {
          'Name': name,
          'PhoneNumber': phoneNumber,
        },
      );
      print('BookingService: Doctor booking response: $response');
      return {
        'success': true,
        'message': response['message'] ?? 'Doctor booking confirmed',
      };
    } catch (e) {
      String message = 'Failed to book doctor';
      if (e.toString().contains('Booking limit exceeded')) {
        message = 'Maximum 5 bookings reached for this doctor. Try again after 24 hours.';
      } else if (e.toString().contains('401')) {
        message = 'Unauthorized: Please log in again';
      } else if (e.toString().contains('404')) {
        message = 'Doctor not found';
      } else {
        message = 'Failed to book doctor: $e';
      }
      print('BookingService: Doctor booking failed: $message, error: $e');
      return {
        'success': false,
        'message': message,
      };
    }
  }

  // Books a nurse with the given ID
  Future<Map<String, dynamic>> bookNurse({
    required String nurseId,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      print('BookingService: Attempting to book nurse with ID: $nurseId');
      final response = await apiConsumer.post(
        Endpoints.bookNurse(nurseId),
        data: {
          'Name': name,
          'PhoneNumber': phoneNumber,
        },
      );
      print('BookingService: Nurse booking response: $response');
      return {
        'success': true,
        'message': response['message'] ?? 'Nurse booking confirmed',
      };
    } catch (e) {
      String message = 'Failed to book nurse';
      if (e.toString().contains('Booking limit exceeded')) {
        message = 'Nurse is booked for the next 24 hours. Try again later.';
      } else if (e.toString().contains('401')) {
        message = 'Unauthorized: Please log in again';
      } else if (e.toString().contains('404')) {
        message = 'Nurse not found';
      } else {
        message = 'Failed to book nurse: $e';
      }
      print('BookingService: Nurse booking failed: $message, error: $e');
      return {
        'success': false,
        'message': message,
      };
    }
  }

  // Fetches doctors by department
  Future<List<DoctorModel>> fetchDoctorsByDepartment(String department) async {
    try {
      print('BookingService: Fetching doctors for department: $department');
      final response = await apiConsumer.get(
        Endpoints.getDoctorsByDepartment(department),
      );
      print('BookingService: Fetch doctors response: $response');
      if (response is List) {
        final doctors = response.map((json) => DoctorModel.fromJson(json)).toList();
        print('BookingService: Parsed ${doctors.length} doctors');
        return doctors;
      } else {
        final doctor = DoctorModel.fromJson(response);
        print('BookingService: Parsed single doctor: ${doctor.toJson()}');
        return [doctor];
      }
    } catch (e) {
      print('BookingService: Error fetching doctors: $e');
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  // Fetches nurses by department
  Future<List<NurseModel>> fetchNursesByDepartment(String department) async {
    try {
      print('BookingService: Fetching nurses for department: $department');
      final response = await apiConsumer.get(
        Endpoints.getNursesByDepartment(department),
      );
      print('BookingService: Fetch nurses raw response: $response');
      if (response is List) {
        final nurses = response.map((json) {
          print('BookingService: Parsing nurse JSON: $json');
          return NurseModel.fromJson(json);
        }).toList();
        print('BookingService: Parsed ${nurses.length} nurses: ${nurses.map((n) => n.toJson()).toList()}');
        return nurses;
      } else {
        print('BookingService: Parsing single nurse JSON: $response');
        final nurse = NurseModel.fromJson(response);
        print('BookingService: Parsed single nurse: ${nurse.toJson()}');
        return [nurse];
      }
    } catch (e) {
      print('BookingService: Error fetching nurses: $e');
      throw Exception('Failed to fetch nurses: $e');
    }
  }

  // Fetches all doctors
  Future<List<DoctorModel>> fetchAllDoctors() async {
    try {
      print('BookingService: Fetching all doctors');
      final response = await apiConsumer.get(
        Endpoints.getAllDoctors(),
      );
      print('BookingService: Fetch all doctors response: $response');
      if (response is List) {
        final doctors = response.map((json) => DoctorModel.fromJson(json)).toList();
        print('BookingService: Parsed ${doctors.length} doctors');
        return doctors;
      } else {
        final doctor = DoctorModel.fromJson(response);
        print('BookingService: Parsed single doctor: ${doctor.toJson()}');
        return [doctor];
      }
    } catch (e) {
      print('BookingService: Error fetching all doctors: $e');
      throw Exception('Failed to fetch all doctors: $e');
    }
  }

  // Fetches all nurses
  Future<List<NurseModel>> fetchAllNurses() async {
    try {
      print('BookingService: Fetching all nurses');
      final response = await apiConsumer.get(
        Endpoints.getAllNurses(),
      );
      print('BookingService: Fetch all nurses response: $response');
      if (response is List) {
        final nurses = response.map((json) => NurseModel.fromJson(json)).toList();
        print('BookingService: Parsed ${nurses.length} nurses');
        return nurses;
      } else {
        final nurse = NurseModel.fromJson(response);
        print('BookingService: Parsed single nurse: ${nurse.toJson()}');
        return [nurse];
      }
    } catch (e) {
      print('BookingService: Error fetching all nurses: $e');
      throw Exception('Failed to fetch all nurses: $e');
    }
  }

  // Fetches a doctor by ID
  Future<DoctorModel> fetchDoctorById(String id) async {
    try {
      print('BookingService: Fetching doctor with ID: $id');
      final response = await apiConsumer.get(
        Endpoints.getDoctorById(id),
      );
      print('BookingService: Fetch doctor response: $response');
      final doctor = DoctorModel.fromJson(response);
      print('BookingService: Parsed doctor: ${doctor.toJson()}');
      return doctor;
    } catch (e) {
      print('BookingService: Error fetching doctor: $e');
      throw Exception('Failed to fetch doctor: $e');
    }
  }

  // Fetches a nurse by ID
  Future<NurseModel> fetchNurseById(String id) async {
    try {
      print('BookingService: Fetching nurse with ID: $id');
      final response = await apiConsumer.get(
        Endpoints.getNurseById(id),
      );
      print('BookingService: Fetch nurse response: $response');
      final nurse = NurseModel.fromJson(response);
      print('BookingService: Parsed nurse: ${nurse.toJson()}');
      return nurse;
    } catch (e) {
      print('BookingService: Error fetching nurse: $e');
      throw Exception('Failed to fetch nurse: $e');
    }
  }
}