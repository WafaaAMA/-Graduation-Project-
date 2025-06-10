part of 'booking_cubit.dart';

// Abstract base class for all booking states
abstract class BookingState {}

// Initial state when the cubit is created
class BookingInitial extends BookingState {}

// State when a booking operation is in progress
class BookingLoading extends BookingState {}

// State when a booking is successful
class BookingSuccess extends BookingState {
  final String message;

  BookingSuccess({required this.message});
}

// State when a booking or fetch operation fails
class BookingFailure extends BookingState {
  final String message;
  final List<String>? fullyBookedDoctors;
  final List<String>? fullyBookedNurses;

  BookingFailure({
    required this.message,
    this.fullyBookedDoctors,
    this.fullyBookedNurses,
  });
}

// State when doctors are successfully fetched
class DoctorsFetched extends BookingState {
  final List<DoctorModel> doctors;
  final List<String> fullyBookedDoctors;

  DoctorsFetched({
    required this.doctors,
    this.fullyBookedDoctors = const [],
  });
}

// State when nurses are successfully fetched
class NursesFetched extends BookingState {
  final List<NurseModel> nurses;
  final List<String> fullyBookedNurses;

  NursesFetched({
    required this.nurses,
    this.fullyBookedNurses = const [],
  });
}

// State when a single doctor is fetched
class DoctorFetched extends BookingState {
  final DoctorModel doctor;

  DoctorFetched({required this.doctor});
}

// State when a single nurse is fetched
class NurseFetched extends BookingState {
  final NurseModel nurse;

  NurseFetched({required this.nurse});
}