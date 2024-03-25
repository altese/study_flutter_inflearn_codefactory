/*
  Splah Screen
  : 여러 데이터들을 불러오고 사용자를 어떤 페이지로 보낼지 판단하는 기본 페이지 

  - 이 어플에선 토큰을 확인하는 용도 
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/const/colors.dart';
import 'package:inflearn_code_factory/common/layout/default_layout.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static String get routeName => 'splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
