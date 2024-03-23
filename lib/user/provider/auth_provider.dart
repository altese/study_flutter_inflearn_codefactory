import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inflearn_code_factory/user/model/user_model.dart';
import 'package:inflearn_code_factory/user/provider/user_me_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    // userMeProvider가 변경되었을 때만 알림
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) notifyListeners();
    });
  }

  // 앱을 실행하면 토큰 확인 -> 로그인 스크린/홈 스크린
  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    final login = state.matchedLocation == '/login';

    // 유저 정보 없을 때
    if (user == null) {
      return login ? null : '/login';
    }

    // 유저 정보 있을 때
    // UserModel
    if (user is UserModel) {
      return login || state.matchedLocation == '/splash' ? '/' : null;
    }

    // 에러: 토큰이 잘못됐을 때
    // UserModelError
    if (user is UserModelError) {
      return !login ? '/login' : null;
    }

    return null;
  }
}
