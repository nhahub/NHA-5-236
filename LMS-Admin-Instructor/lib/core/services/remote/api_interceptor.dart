import 'package:dio/dio.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';

class ApiInterceptor extends Interceptor {
  final CacheHelper _cacheHelper = CacheHelper();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains('/auth/login') &&
        !options.path.contains('/auth/register')) {
      final token = _cacheHelper.getData(key: ApiKey.accessToken);
      if (token != null) {
        options.headers[ApiKey.authorization] = 'Bearer $token';
      }
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final path = err.requestOptions.path;

      if (!path.contains('/auth/login') &&
          !path.contains(EndPoint.refreshToken)) {
        final refreshToken = _cacheHelper.getData(key: ApiKey.refreshToken);

        if (refreshToken != null) {
          try {
            final refreshDio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));
            final response = await refreshDio.post(
              EndPoint.refreshToken,
              data: {'refresh': refreshToken},
            );

            if (response.statusCode == 200 || response.statusCode == 201) {
              final responseData = response.data;
              String? newAccessToken;

              if (responseData is Map<String, dynamic>) {
                if (responseData.containsKey('data')) {
                  newAccessToken = responseData['data']['access'];
                } else if (responseData.containsKey('access')) {
                  newAccessToken = responseData['access'];
                }
              }

              if (newAccessToken != null) {
                await _cacheHelper.saveData(
                  key: ApiKey.accessToken,
                  value: newAccessToken,
                );

                err.requestOptions.headers[ApiKey.authorization] =
                    'Bearer $newAccessToken';

                final retryDio = Dio();
                final retryResponse = await retryDio.fetch(err.requestOptions);
                return handler.resolve(retryResponse);
              }
            }
          } catch (e) {
            await _cacheHelper.clearUserData();
          }
        }
      }
    }
    super.onError(err, handler);
  }
}
