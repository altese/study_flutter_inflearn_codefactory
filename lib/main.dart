import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/view/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    // 라우팅을 할  때 BuildContext가 필요한 경우가 있기 때문에 MaterialApp으로 한 번 감싼다.
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard', useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
