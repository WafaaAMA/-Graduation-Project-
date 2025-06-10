// class Endpoints {
//   static const String baseUrl = "http://carefirstapp.runasp.net/";

//   // User-related endpoints
//   static const String signIn = "user/Login";
//   static const String signUp = "user/create";
//   static String userInfo() {
//     return "user/info";
//   }
//   static String sendOtpPhone(String phone) {
//     return "user/Forget/password/phone/$phone";

//   }
//   static String sendOtpEmail(String email) {
//     return "user/Forget/password/email/$email";
//   }
//   static const String resetPassword = "user/resetPassword";
//   static String addDoctorReview(String doctorId) {
//     return "User/Review/Doctor/$doctorId";
//   }
//   //  static const String verifyOtp = '$baseUrl/user/verifyOtp';
//   static const String addProfilePicture = "User/picture";
//   static const String deleteProfilePicture = "User/picture";
//   static const String updateProfilePicture = "User/picture";
//   static const String updateProfile = "user/update";

//   // Booking-related endpoints
//   // static String bookDoctor(String doctorId) {
//   //   return "Booking/Doctor/$doctorId";
//   // }
//   // 
  
//   static String bookDoctor(String doctorId) => '/Booking/Doctor/$doctorId';
//   static String bookNurse(String nurseId) => '/Booking/Nurse/$nurseId';
//   static String getDoctorsByDepartment(String department) => '/Doctor/Get?Department=$department';
//   static String getNursesByDepartment(String department) => '/Nurse/Get?Department=$department';
//   static String getAllDoctors() => '/Doctor/Get';
//   static String getAllNurses() => '/Nurse/Get';
//   static String getDoctorById(String id) => '/Doctor/ID/$id';
//   static String getNurseById(String id) => '/Nurse/id/$id';
// }

class Endpoints {
  // Using the production base URL from Booking.postman_collection
  static const String baseUrl = "http://carefirstapp.runasp.net/";

  // User-related endpoints
  static const String signIn = "user/Login";
  static const String signUp = "user/create";
  static String userInfo() => "user/info";
  static String sendOtpPhone(String phone) => "user/Forget/password/phone/$phone";
  static String sendOtpEmail(String email) => "user/Forget/password/email/$email";
  static const String resetPassword = "user/resetPassword";
  static String addDoctorReview(String doctorId) => "User/Review/Doctor/$doctorId";
  static const String addProfilePicture = "User/picture";
  static const String deleteProfilePicture = "User/picture";
  static const String updateProfilePicture = "User/picture";
  static const String updateProfile = "user/update";

  // Doctor endpoints
  static String getAllDoctors() => "Doctor/Get";
  static String getDoctorById(String id) => "Doctor/ID/$id";
  static String getDoctorsByDepartment(String department) => "Doctor/Get?Department=$department";
  static String bookDoctor(String doctorId) => "Booking/Doctor/$doctorId";

  // Nurse endpoints
  static String getAllNurses() => "Nurse/Get";
  static String getNurseById(String id) => "Nurse/id/$id";
  static String getNursesByDepartment(String department) => "Nurse/Get?Department=$department";
  static String bookNurse(String nurseId) => "Booking/Nurse/$nurseId";
}
  // Booking-related endpoints
  // static String bookDoctor(String doctorId) => "Booking/Doctor/$doctorId";
  // static String bookNurse(String nurseId) => "Booking/Nurse/$nurseId";
  // static String getDoctorsByDepartment(String department) => "Doctor/Get?Department=$department";
  // static String getNursesByDepartment(String department) => "Nurse/Get?Department=$department";
  // static String getAllDoctors() => "Doctor/Get";
  // static String getAllNurses() => "Nurse/Get";
  // static String getDoctorById(String id) => "Doctor/ID/$id";
  // static String getNurseById(String id) => "Nurse/id/$id";



class ApiKey {
  static const String token = "token";
  static const String email = "Email";
  static const String password = "Password";
  static const String name = "Name";
  static const String phoneNumber = "PhoneNumber";
  static const String confirmPassword = "ConfirmPassword";
  static const String gender = "Gender";
  static const String age = "Age";
  static const String rating = "Rating";
  static const String comment = "Comment";
  static const String otpToken = "Token";
  static const String profilpic = "file";
  static const String newPassword = "Password";
  static const String confirmNewPassword = "ConfirmPassword";
}