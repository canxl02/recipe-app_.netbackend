// ignore_for_file: unnecessary_new

import 'package:dio/dio.dart';
import '../model/mobile_api_response.dart';

class ApiClient {
  Dio? _dio;
  final _baseUrl = "http://192.168.1.113:7154/api/";

  var onResponseCallback;
  var onErrorCallback;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json; charset=utf-8",
        "X-Requested-With": "XMLHttpRequest",
      },
      validateStatus: (status) {
        return status != null && status < 500; // 500 ve üzeri hataları tetikle
      },
    ));
    initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint,
      {Map<String, dynamic>? filter}) async {
    _dio!.options.method = "POST";
    Response response = await _dio!.get(endPoint, queryParameters: filter);
    print("Get Dio Response: ${response.toString()}");
    return response;
  }

  Future<Response> postRequest(String endPoint, dynamic formData) async {
    _dio!.options.method = "POST";
    Response response = await _dio!.post(endPoint, data: formData);
    print("Post Dio Response: ${response.toString()}");
    return response;
  }

  Future<Response> postRequestQueryString(
      String endPoint, dynamic formData) async {
    _dio!.options.method = "POST";
    Response response =
        await _dio!.post('$endPoint?${Transformer.urlEncodeMap(formData)}');
    print("Post Dio Response: ${response.toString()}");
    return response;
  }

  // Yeni metod: Delete request
  Future<Response> deleteRequest(String endPoint, int id) async {
    _dio!.options.method = "DELETE";
    Response response = await _dio!.delete('$endPoint/$id');
    print("Delete Dio Response: ${response.toString()}");
    return response;
  }

  void initializeInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
          print('Error: ${error.response?.data['message'] ?? error.message}');
          MobileApiResponse apiResponse = MobileApiResponse(
            errorMessage: error.response?.data['message'] ?? error.message,
          );
          onErrorCallback(apiResponse);
          handler.next(error);
        },
        onRequest: (RequestOptions request, RequestInterceptorHandler handler) {
          print("${request.method} | ${request.path}");
          handler.next(request);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          var map = Map<String, dynamic>.from(response.data);
          MobileApiResponse apiResponse = MobileApiResponse.fromJson(map);
          print('Message: ${apiResponse.message}');
          onResponseCallback(apiResponse);
          handler.next(response);
        },
      ),
    );
  }
}
