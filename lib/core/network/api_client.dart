import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/config/env.dart';
import 'package:sawa_app/core/network/api_exception.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/core/storage/storage_service.dart';

class ApiClient {
  late final Dio dio;
  bool _isRefreshing = false;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: Env.connectTimeout,
        receiveTimeout: Env.receiveTimeout,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = Get.find<StorageService>().getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final isAuthCall = error.requestOptions.path.contains('/auth/');

          // ✅ 401 ومش نداء تسجيل دخول/تسجيل نفسه -> نحاول نجدد التوكن مرة وحدة
          if (error.response?.statusCode == 401 && !isAuthCall && !_isRefreshing) {
            _isRefreshing = true;
            try {
              final storage = Get.find<StorageService>();
              final refreshToken = storage.getRefreshToken();
              if (refreshToken == null) throw Exception('no refresh token');

              final refreshResponse = await Dio(BaseOptions(baseUrl: Env.baseUrl)).post(
                '/auth/refresh',
                data: {'refreshToken': refreshToken},
              );

              final data = refreshResponse.data['data'] ?? refreshResponse.data;
              final newAccessToken = data['accessToken'];
              final newRefreshToken = data['refreshToken'];
              await storage.saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken);

              // ✅ نعيد الطلب الأصلي بالتوكن الجديد
              _isRefreshing = false;
              final retryOptions = error.requestOptions;
              retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
              final retryResponse = await dio.fetch(retryOptions);
              return handler.resolve(retryResponse);
            } catch (_) {
              _isRefreshing = false;
              await Get.find<StorageService>().clearSession();
              Get.offAllNamed(AppRoutes.LOGIN);
            }
          } else if (error.response?.statusCode == 401 && isAuthCall) {
            // فشل تسجيل الدخول نفسه أو التوكن مرفوض تمامًا
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      return await dio.get(path, queryParameters: query);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await dio.patch(path, data: data);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await dio.delete(path, data: data);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  ApiException _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return ApiException('انتهت مهلة الاتصال، تحقق من الإنترنت وحاول مجددًا');
    }
    if (e.type == DioExceptionType.connectionError) {
      return ApiException('لا يوجد اتصال بالإنترنت');
    }

    final statusCode = e.response?.statusCode;
    final data = e.response?.data;
    final serverMessage = data is Map ? (data['message'] ?? data['error']) : null;

    switch (statusCode) {
      case 400:
        return ApiException(serverMessage ?? 'طلب غير صحيح', statusCode: 400);
      case 401:
        return ApiException(serverMessage ?? 'بيانات الدخول غير صحيحة', statusCode: 401);
      case 403:
        return ApiException('لا تملك صلاحية القيام بهذا الإجراء', statusCode: 403);
      case 404:
        return ApiException(serverMessage ?? 'العنصر المطلوب غير موجود', statusCode: 404);
      case 409:
        return ApiException(serverMessage ?? 'هذا البريد الإلكتروني مستخدم مسبقًا', statusCode: 409);
      case 422:
        return ApiException(serverMessage ?? 'البيانات المدخلة غير صحيحة', statusCode: 422);
      case 500:
        return ApiException('حدث خطأ بالسيرفر، حاول لاحقًا', statusCode: 500);
      default:
        return ApiException(serverMessage ?? 'حدث خطأ غير متوقع، حاول مجددًا', statusCode: statusCode);
    }
  }
}