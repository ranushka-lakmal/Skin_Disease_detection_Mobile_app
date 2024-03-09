import 'package:dio/dio.dart';

class DioUploadService {

  Future<dynamic> uploadPhotos(String path) async {


    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(path)
    });
   // var response = await Dio().post('http://44.204.54.3:8080/api/predict', data: formData);


    var response = await Dio().post('http://127.0.0.1:5000/predict', data: formData);
    return response.data;
  }

}

///flutter build apk --release --build-name="1.0.1" --build-number="1"