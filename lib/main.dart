import 'package:flutter/material.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    // 라우팅을 할  때 BuildContext가 필요한 경우가 있기 때문에 MaterialApp으로 한 번 감싼다.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Container()),
    );
  }
}
