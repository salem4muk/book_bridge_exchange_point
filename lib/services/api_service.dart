import 'package:dio/dio.dart';

import '../constans/url.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrlApi,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}
