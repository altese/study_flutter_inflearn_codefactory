import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inflearn_code_factory/common/const/data.dart';
import 'package:inflearn_code_factory/user/model/user_model.dart';
import 'package:inflearn_code_factory/user/repository/auth_repository.dart';
import 'package:inflearn_code_factory/user/repository/user_me_repository.dart';

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // 내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // 토큰이 존재하지 않으면 요청을 보내지 않는다.
    if (refreshToken == null || accessToken == null) {
      state = null; // 로그아웃 상태
      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      // 일단 로딩
      state = UserModelLoading();

      // 토큰 받아와서 저장
      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      // 사용자 정보 state에 저장
      final userResp = await repository.getMe();

      state = userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');
    }
    return Future.value(state);
  }

  Future<void> logOut() async {
    // await storage.delete(key: REFRESH_TOKEN_KEY);
    // await storage.delete(key: ACCESS_TOKEN_KEY);

    // 동시에 지우고 싶을 때
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);

    state = null;
  }
}
