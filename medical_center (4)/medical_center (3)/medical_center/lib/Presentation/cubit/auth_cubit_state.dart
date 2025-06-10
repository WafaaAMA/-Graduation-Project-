part of 'auth_cubit_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

class AuthLoading extends AuthCubitState {}

class AUthSuccess extends AuthCubitState {}

class AuthError extends AuthCubitState {
  final String message;
  AuthError({required this.message});
}

class SignUpLoading extends AuthCubitState {}

class SignUpSuccess extends AuthCubitState {}

class SignUpError extends AuthCubitState {
  final String message;
  SignUpError({required this.message});
}

class GetUserLoading extends AuthCubitState {}

class GetUserSuccess extends AuthCubitState {
  final UserModel user;
  GetUserSuccess({required this.user});
}

class GetUserError extends AuthCubitState {
  final String message;
  GetUserError({required this.message});
}

class UpdateProfileLoading extends AuthCubitState {}

class UpdateProfileSuccess extends AuthCubitState {
  final UserModel user;
  UpdateProfileSuccess({required this.user});
}

class UpdateProfileError extends AuthCubitState {
  final String message;
  UpdateProfileError({required this.message});
}

class Uploadimage extends AuthCubitState {}

class ProfilePictureUploaded extends AuthCubitState {}

class ProfilePictureDeleted extends AuthCubitState {}

class SendOtpLoading extends AuthCubitState {}

class SendOtpSuccess extends AuthCubitState {}

class SendOtpError extends AuthCubitState {
  final String message;
  SendOtpError({required this.message});
}

class VerifyOtpLoading extends AuthCubitState {}

class VerifyOtpSuccess extends AuthCubitState {}

class VerifyOtpError extends AuthCubitState {
  final String message;
  VerifyOtpError({required this.message});
}

class ResetPasswordLoading extends AuthCubitState {}

class ResetPasswordSuccess extends AuthCubitState {}

class ResetPasswordError extends AuthCubitState {
  final String message;
  ResetPasswordError({required this.message});
}