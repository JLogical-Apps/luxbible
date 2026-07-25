import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

class AppCheckInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await FirebaseAppCheck.instance.getToken();
      if (token case final token? when token.isNotEmpty) {
        options.headers['X-Firebase-AppCheck'] = token;
        handler.next(options);
        return;
      }

      handler.reject(DioException(requestOptions: options, message: 'Firebase App Check did not return a token'));
    } catch (error, stackTrace) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          stackTrace: stackTrace,
          message: 'Unable to obtain a Firebase App Check token',
        ),
      );
    }
  }
}
