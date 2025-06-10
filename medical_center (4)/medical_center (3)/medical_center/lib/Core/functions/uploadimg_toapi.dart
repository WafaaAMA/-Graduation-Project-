// import 'package:dio/dio.dart';
// import 'package:http/http.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

Future UploadImagetoApi(XFile img) {
  return MultipartFile.fromFile(
    img.path,
    filename: img.path.split("/").last,
  );
}