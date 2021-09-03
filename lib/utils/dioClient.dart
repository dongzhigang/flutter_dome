// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

class DioClient {
  final String backUrl = "http://12.1.60.37:3000";
  static Dio _dio = new Dio();
  // 构造实体类函数
  DioClient() {
    BaseOptions options = BaseOptions();
    options.baseUrl = backUrl;
    _dio.options = options;
  }
  get(String url, {Map<String, dynamic>? body, Function? callback}) async {
    dynamic response = await _dio.get(url, queryParameters: body);
    print(response);
    return response;
  }
}
