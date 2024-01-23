/*
  Splah Screen
  : 여러 데이터들을 불러오고 사용자를 어떤 페이지로 보낼지 판단하는 기본 페이지 

  - 이 어플에선 토큰을 확인하는 용도 
*/

import 'package:flutter/material.dart';
import 'package:inflearn_code_factory/common/const/colors.dart';
import 'package:inflearn_code_factory/common/const/data.dart';
import 'package:inflearn_code_factory/common/layout/default_layout.dart';
import 'package:inflearn_code_factory/common/view/root_tab.dart';
import 'package:inflearn_code_factory/user/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkToken();
    // deleteToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // 토큰이 없으면 로그인 스크린
    if (refreshToken == null || accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    } else {
      // 토큰이 있으면 루트 탭
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const RootTab(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return DefaultLayout(
      backgroundColor: POINT_COLOR_PURPLE,
      title: null,
      child: SizedBox(
        width: size.width, // 가운데 정렬을 위해
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'POCHACCO',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            Image.asset(
              'asset/img/logo/pochacco_logo.PNG',
              width: size.width / 3,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: POINT_COLOR_YELLOW,
            )
          ],
        ),
      ),
    );
  }
}
