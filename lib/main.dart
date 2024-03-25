import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/provider/go_router.dart';

void main() {
  runApp(const ProviderScope(child: _App()));
}

class _App extends ConsumerWidget {
  const _App();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // 라우팅을 할 때 BuildContext가 필요한 경우가 있기 때문에 MaterialApp으로 감싼다.
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Pretendard', useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      // home: const SplashScreen(),
    );
  }
}
