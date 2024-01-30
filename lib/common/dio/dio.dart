import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inflearn_code_factory/common/const/data.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1. 요청을 보낼 때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    // 로그인 시 액세스 토큰을 자동으로 적용하자
    // 요청을 보낼 때마다 요청의 Header에 accessToken: true라는 값이 있다면
    // 실제 토큰을 storage에서 가져와 authorization: Bearer $token으로 헤더 변경
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    // 리프레시 토큰 자동 적용
    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2. 응답을 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 3. 에러가 났을 때
  // 중요한 것: 어떤 상황을 catch하고 싶은가?
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401: 액세스 토큰에 문제가 있을 때 토큰을 재발급 -> 재발급한 토큰으로 요청
    print('[ERROR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    // 1. 리프레시 토큰 가져오기
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // 2. 리프레시 토큰이 없으면 에러 던진다.
    if (refreshToken == null) {
      // 에러 생성
      return handler.reject(err);
      // 에러 없이 응답 받은 것
      // response에 임의의 값을 넣으면 에러가 나지 않은 것처럼 실행할 수 있다.
      // return handler.resolve(response);
    }

    // 3. 401에러인지 확인
    final isStatus401 = err.response?.statusCode == 401;
    // 4. 액세스 토큰을 재발급 받으려다가 에러난 건지 확인
    // 이 경우 리프레시 토큰 자체에 문제가 있다는 의미 -> 새로 다시 요청을 해봤자 다시 에러가 난다. -> reject
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    // 액세스 토큰 재발급 받는 과정이 아니었는데 401 에러가 났을 때
    // -> 액세스 토큰에 문제가 있으므로 재발급 받는다.
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      // 이 과정에서 에러가 난다면 더 이상 토큰을 리프레시 할 수 있는 상황이 아님
      // 원인을 알 수 없는 에러다. -> 에러 던지기
      try {
        // 액세스 토큰 재발급
        final response = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {'authorization': 'Bearer $refreshToken'},
          ),
        );

        final accessToken = response.data['accessToken'];

        // 에러가 났던 요청의 옵션들 + 헤더에 재발급한 accessToken 넣어서 재요청
        final options = err.requestOptions;

        options.headers.addAll({'authorization': 'Bearer $accessToken'});
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        final resp = await dio.fetch(options); // 재요청

        return handler.resolve(resp); // 응답 반환
      } catch (e) {
        return handler.reject(err);
      }
    }

    super.onError(err, handler);
  }
}
