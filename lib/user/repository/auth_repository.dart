import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/const/data.dart';
import 'package:inflearn_code_factory/common/dio/dio.dart';
import 'package:inflearn_code_factory/common/utils/data_utils.dart';
import 'package:inflearn_code_factory/product/model/login_response.dart';
import 'package:inflearn_code_factory/product/model/token_response.dart';

final authRepositoryProvier = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: 'http://$ip/auth', dio: dio);
});

class AuthRepository {
  // 'http://$ip/auth'
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username : $password');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {'authorization': 'Basic $serialized'},
      ),
    );

    return LoginResponse.fromJson(resp.data);
  }

  Future<TokenResponse> getToken(WidgetRef ref) async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(
        // headers: {'authorization': 'Bearer $refreshToken'},
        // interceptor에서 처리된다.
        headers: {'refreshToken': 'true'},
      ),
    );

    return TokenResponse.fromJson(resp.data);
  }
}
