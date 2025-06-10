import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Data/models/doctor_model.dart';
import 'package:medical_center/Data/models/nurse_model.dart';
import 'package:medical_center/Data/services/book_services.dart';

part 'booking_state.dart';

// Cubit for managing booking-related state and operations
class BookingCubit extends Cubit<BookingState> {
  final BookingService bookingService;
  final Set<String> _fullyBookedDoctors = {};
  final Set<String> _fullyBookedNurses = {};

  BookingCubit(this.bookingService) : super(BookingInitial());

  // Checks if a doctor is fully booked
  bool isDoctorFullyBooked(String doctorId) => _fullyBookedDoctors.contains(doctorId);

  // Checks if a nurse is fully booked
  bool isNurseFullyBooked(String nurseId) => _fullyBookedNurses.contains(nurseId);

  // Resets the fully booked doctors list
  void resetFullyBookedDoctors() {
    print('BookingCubit: Resetting fully booked doctors');
    _fullyBookedDoctors.clear();
  }

  // Resets the fully booked nurses list
  void resetFullyBookedNurses() {
    print('BookingCubit: Resetting fully booked nurses');
    _fullyBookedNurses.clear();
  }

  // Books a doctor
  Future<void> bookDoctor({
    required String doctorId,
    required String name,
    required String phoneNumber,
  }) async {
    emit(BookingLoading());
    try {
      print('BookingCubit: Booking doctor with ID: $doctorId');
      final result = await bookingService.bookDoctor(
        doctorId: doctorId,
        name: name,
        phoneNumber: phoneNumber,
      );
      print('BookingCubit: Book doctor result: $result');
      if (result['success']) {
        emit(BookingSuccess(message: result['message']));
        _fullyBookedDoctors.remove(doctorId);
      } else {
        if (result['message'].contains('Booking limit exceeded')) {
          _fullyBookedDoctors.add(doctorId);
          emit(BookingFailure(
              message: result['message'],
              fullyBookedDoctors: _fullyBookedDoctors.toList()));
        } else {
          emit(BookingFailure(message: result['message']));
        }
      }
    } catch (e) {
      print('BookingCubit: Error booking doctor: $e');
      String message = 'Failed to book doctor: $e';
      if (e.toString().contains('Booking limit exceeded')) {
        _fullyBookedDoctors.add(doctorId);
        message = 'Maximum 5 bookings reached for this doctor. Try again after 24 hours.';
        emit(BookingFailure(
            message: message,
            fullyBookedDoctors: _fullyBookedDoctors.toList()));
      } else {
        emit(BookingFailure(message: message));
      }
    }
  }

  // Books a nurse
  Future<void> bookNurse({
    required String nurseId,
    required String name,
    required String phoneNumber,
  }) async {
    emit(BookingLoading());
    try {
      print('BookingCubit: Booking nurse with ID: $nurseId');
      final result = await bookingService.bookNurse(
        nurseId: nurseId,
        name: name,
        phoneNumber: phoneNumber,
      );
      print('BookingCubit: Book nurse result: $result');
      if (result['success']) {
        emit(BookingSuccess(message: result['message']));
        _fullyBookedNurses.remove(nurseId);
      } else {
        if (result['message'].contains('Booking limit exceeded')) {
          _fullyBookedNurses.add(nurseId);
          emit(BookingFailure(
              message: result['message'],
              fullyBookedNurses: _fullyBookedNurses.toList()));
        } else {
          emit(BookingFailure(message: result['message']));
        }
      }
    } catch (e) {
      print('BookingCubit: Error booking nurse: $e');
      String message = 'Failed to book nurse: $e';
      if (e.toString().contains('Booking limit exceeded')) {
        _fullyBookedNurses.add(nurseId);
        message = 'Nurse is booked for the next 24 hours. Try again later.';
        emit(BookingFailure(
            message: message,
            fullyBookedNurses: _fullyBookedNurses.toList()));
      } else {
        emit(BookingFailure(message: message));
      }
    }
  }

  // Fetches doctors by department
  Future<void> fetchDoctorsByDepartment(String department) async {
    emit(BookingLoading());
    try {
      print('BookingCubit: Fetching doctors for department: $department');
      final doctors = await bookingService.fetchDoctorsByDepartment(department);
      print('BookingCubit: Fetched ${doctors.length} doctors');
      emit(DoctorsFetched(
          doctors: doctors, fullyBookedDoctors: _fullyBookedDoctors.toList()));
    } catch (e) {
      print('BookingCubit: Error fetching doctors: $e');
      String errorMessage = 'Failed to fetch doctors: ';
      if (e.toString().contains('401')) {
        errorMessage += 'Authentication issue, please log in again';
      } else if (e.toString().contains('404')) {
        errorMessage += 'Department not found';
      } else if (e.toString().contains('Network')) {
        errorMessage += 'Internet connection issue';
      } else {
        errorMessage += e.toString();
      }
      emit(BookingFailure(message: errorMessage));
    }
  }

  // Fetches nurses by department
  Future<void> fetchNursesByDepartment(String department) async {
    emit(BookingLoading());
    try {
      print('BookingCubit: Fetching nurses for department: $department');
      final nurses = await bookingService.fetchNursesByDepartment(department);
      print('BookingCubit: Fetched ${nurses.length} nurses');
      emit(NursesFetched(
          nurses: nurses, fullyBookedNurses: _fullyBookedNurses.toList()));
    } catch (e) {
      print('BookingCubit: Error fetching nurses: $e');
      String errorMessage = 'Failed to fetch nurses: ';
      if (e.toString().contains('401')) {
        errorMessage += 'Authentication issue, please log in again';
      } else if (e.toString().contains('404')) {
        errorMessage += 'Department not found';
      } else if (e.toString().contains('Network')) {
        errorMessage += 'Internet connection issue';
      } else {
        errorMessage += e.toString();
      }
      emit(BookingFailure(message: errorMessage));
    }
  }

  // Fetches all doctors
  Future<void> fetchAllDoctors() async {
    emit(BookingLoading());
    try {
      print('BookingCubit: Fetching all doctors');
      final doctors = await bookingService.fetchAllDoctors();
      print('BookingCubit: Fetched ${doctors.length} doctors');
      emit(DoctorsFetched(
          doctors: doctors, fullyBookedDoctors: _fullyBookedDoctors.toList()));
    } catch (e) {
      print('BookingCubit: Error fetching all doctors: $e');
      String errorMessage = 'Failed to fetch all doctors: ';
      if (e.toString().contains('401')) {
        errorMessage += 'Authentication issue, please log in again';
      } else if (e.toString().contains('404')) {
        errorMessage += 'Doctors not found';
      } else if (e.toString().contains('Network')) {
        errorMessage += 'Internet connection issue';
      } else {
        errorMessage += e.toString();
      }
      emit(BookingFailure(message: errorMessage));
    }
  }

  // Fetches all nurses
  Future<void> fetchAllNurses() async {
    emit(BookingLoading());
    try {
      print('BookingCubit: Fetching all nurses');
      final nurses = await bookingService.fetchAllNurses();
      print('BookingCubit: Fetched ${nurses.length} nurses');
      emit(NursesFetched(
          nurses: nurses, fullyBookedNurses: _fullyBookedNurses.toList()));
    } catch (e) {
      print('BookingCubit: Error fetching all nurses: $e');
      String errorMessage = 'Failed to fetch all nurses: ';
      if (e.toString().contains('401')) {
        errorMessage += 'Authentication issue, please log in again';
      } else if (e.toString().contains('404')) {
        errorMessage += 'Nurses not found';
      } else if (e.toString().contains('Network')) {
        errorMessage += 'Internet connection issue';
      } else {
        errorMessage += e.toString();
      }
      emit(BookingFailure(message: errorMessage));
    }
  }

  // Fetches a doctor by ID
  Future<void> fetchDoctorById(String id) async {
    emit(BookingLoading());
    try {
      print('BookingCubit: Fetching doctor with ID: $id');
      final doctor = await bookingService.fetchDoctorById(id);
      print('BookingCubit: Fetched doctor: ${doctor.toJson()}');
      emit(DoctorFetched(doctor: doctor));
    } catch (e) {
      print('BookingCubit: Error fetching doctor: $e');
      String errorMessage = 'Failed to fetch doctor: ';
      if (e.toString().contains('401')) {
        errorMessage += 'Authentication issue, please log in again';
      } else if (e.toString().contains('404')) {
        errorMessage += 'Doctor not found';
      } else if (e.toString().contains('Network')) {
        errorMessage += 'Internet connection issue';
      } else {
        errorMessage += e.toString();
      }
      emit(BookingFailure(message: errorMessage));
    }
  }

  // Fetches a nurse by ID
  Future<void> fetchNurseById(String id) async {
    emit(BookingLoading());
    try {
      print('BookingCubit: Fetching nurse with ID: $id');
      final nurse = await bookingService.fetchNurseById(id);
      print('BookingCubit: Fetched nurse: ${nurse.toJson()}');
      emit(NurseFetched(nurse: nurse));
    } catch (e) {
      print('BookingCubit: Error fetching nurse: $e');
      String errorMessage = 'Failed to fetch nurse: ';
      if (e.toString().contains('401')) {
        errorMessage += 'Authentication issue, please log in again';
      } else if (e.toString().contains('404')) {
        errorMessage += 'Nurse not found';
      } else if (e.toString().contains('Network')) {
        errorMessage += 'Internet connection issue';
      } else {
        errorMessage += e.toString();
      }
      emit(BookingFailure(message: errorMessage));
    }
  }
}