import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medical_center/Core/api/api_consumer.dart';
import 'package:medical_center/Core/api/database/cachehelper.dart';
import 'package:medical_center/Core/api/endpoints.dart';
import 'package:medical_center/Core/functions/uploadimg_toApi.dart';
import 'package:medical_center/Core/models/signin_models.dart';
import 'package:medical_center/Data/models/user_model.dart';
import 'package:meta/meta.dart';

import '../../Core/models/user_model.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit(this.api) : super(AuthCubitInitial());
  final ApiConsumer api;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailup = TextEditingController();
  final TextEditingController passwordup = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  final TextEditingController forgotPasswordInput = TextEditingController();

  SigninModel? user;
  XFile? profileImage;

  Future<void> signIn() async {
    try {
      print('Attempting to sign in with email: ${email.text}');
      emit(AuthLoading());
      final res = await api.post(
        Endpoints.signIn,
        data: {
          'email': email.text.trim(),
          'password': password.text,
        },
      );
      user = SigninModel.fromJson(res);
      await CacheHelper.saveData(key: ApiKey.token, value: user!.token);
      print('Sign in successful, token saved');
      await getUserData();
      emit(AUthSuccess());
    } catch (e) {
      print('Sign in failed: $e');
      if (e is DioException && e.response != null) {
        String errorMessage = 'Unknown error';
        if (e.response?.data is Map) {
          final data = e.response?.data as Map;
          errorMessage = data['message']?.toString() ??
              data['error']?.toString() ??
              data.toString();
        } else if (e.response?.data is String) {
          errorMessage = e.response!.data.toString();
        } else {
          errorMessage = 'Unexpected API response: ${e.response?.data}';
        }
        if (errorMessage.toLowerCase().contains('invalid user data')) {
          emit(AuthError(message: 'invalid_user_data'));
        } else {
          emit(AuthError(message: errorMessage));
        }
      } else {
        emit(AuthError(message: e.toString()));
      }
    }
  }

  Future<void> sendOtp({required bool isEmail, required String input}) async {
    try {
      print('Sending OTP to ${isEmail ? "email" : "phone"}: $input');
      emit(SendOtpLoading());
      final response = await api.post(
        isEmail ? Endpoints.sendOtpEmail(input) : Endpoints.sendOtpPhone(input),
        data: {},
      );
      print('OTP sent successfully. Response: $response');
      await CacheHelper.saveData(key: 'otpInput', value: input);
      emit(SendOtpSuccess());
    } catch (e) {
      print('Failed to send OTP: $e');
      emit(SendOtpError(message: e.toString()));
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      print('Storing OTP: $otp');
      emit(VerifyOtpLoading());
      final otpInput = CacheHelper.getStringData(key: 'otpInput');
      if (otpInput == null) {
        throw Exception('No OTP input found in cache');
      }
      await CacheHelper.saveData(key: 'verifiedOtp', value: otp);
      print('OTP stored successfully');
      emit(VerifyOtpSuccess());
    } catch (e) {
      print('Failed to process OTP: $e');
      emit(VerifyOtpError(message: e.toString()));
    }
  }

  Future<void> resetPassword() async {
    try {
      print('Resetting password');
      emit(ResetPasswordLoading());
      final verifiedOtp = CacheHelper.getStringData(key: 'verifiedOtp');
      if (verifiedOtp == null) {
        throw Exception('No verified OTP found in cache');
      }
      await api.post(
        Endpoints.resetPassword,
        data: {
          'Token': verifiedOtp,
          'Password': newPassword.text,
          'ConfirmPassword': confirmNewPassword.text,
        },
      );
      print('Password reset successfully');
      await CacheHelper.removeData(key: 'otpInput');
      await CacheHelper.removeData(key: 'verifiedOtp');
      emit(ResetPasswordSuccess());
    } catch (e) {
      print('Failed to reset password: $e');
      emit(ResetPasswordError(message: e.toString()));
    }
  }

 Future<void> uploadImage(XFile img) async {
  try {
    print('Uploading profile image');
    profileImage = img;
    emit(Uploadimage());
    final formData = FormData.fromMap({
      ApiKey.profilpic: await UploadImagetoApi(img),
    });
    final response = await api.post(Endpoints.addProfilePicture, data: formData);
    print('Profile image uploaded. Response: $response');
    final profilePictureUrl = response['profilePictureUrl'] ?? '';
    await CacheHelper.saveData(key: 'profilePictureUrl', value: profilePictureUrl);
    emit(ProfilePictureUploaded());
    await getUserData(); // استدعاء getUserData بعد رفع الصورة مباشرة
  } catch (e) {
    print('Failed to upload profile image: $e');
    emit(AuthError(message: e.toString()));
  }
}

  Future<void> deleteProfilePicture() async {
    try {
      print('Deleting profile picture');
      await api.delete(Endpoints.deleteProfilePicture);
      profileImage = null;
      await CacheHelper.removeData(key: 'profilePictureUrl');
      print('Profile picture deleted successfully');
      emit(ProfilePictureDeleted());
    } catch (e) {
      print('Failed to delete profile picture: $e');
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signUp() async {
    try {
      print('Attempting to sign up with email: ${emailup.text}');
      emit(SignUpLoading());
      final response = await api.post(
        Endpoints.signUp,
        data: {
          ApiKey.name: name.text.trim(),
          ApiKey.email: emailup.text.trim(),
          ApiKey.password: passwordup.text,
          ApiKey.phoneNumber: phone.text.trim(),
          ApiKey.confirmPassword: confirmPassword.text,
          ApiKey.gender: int.parse(gender.text),
          ApiKey.age: int.parse(age.text),
        },
      );
      print('Sign up successful. Response: $response');
      emit(SignUpSuccess());
    } catch (e) {
      print('Sign up failed: $e');
      emit(SignUpError(message: e.toString()));
    }
  }

  Future<void> getUserData() async {
    try {
      print('Fetching user data');
      emit(GetUserLoading());
      final token = await CacheHelper.getData(key: ApiKey.token);
      print('Token for user/info: $token');
      final response = await api.get(Endpoints.userInfo());
      print('User Data Response: $response');
      emit(GetUserSuccess(user: UserModel.fromJson(response)));
    } catch (e) {
      print('Error in getUserData: $e');
      emit(GetUserError(message: e.toString()));
    }
  }

  Future<void> updateProfile() async {
    try {
      print('Updating user profile');
      emit(UpdateProfileLoading());
      final response = await api.post(
        Endpoints.updateProfile,
        data: {
          ApiKey.name: name.text.trim(),
          ApiKey.phoneNumber: phone.text.trim(),
          ApiKey.gender: int.parse(gender.text),
          ApiKey.age: int.parse(age.text),
        },
      );
      print('Profile updated successfully. Response: $response');
      emit(UpdateProfileSuccess(user: UserModel.fromJson(response)));
    } catch (e) {
      print('Failed to update profile: $e');
      emit(UpdateProfileError(message: e.toString()));
    }
  }
}