import 'package:flutter/material.dart';
import 'package:inflearn_code_factory/common/component/custom_text_form_field.dart';

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
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: '이메일을 입력해 주세요.',
              onChanged: (String value) {},
            ),
            CustomTextFormField(
              hintText: '비밀번호를 입력해 주세요.',
              onChanged: (String value) {},
            ),
          ],
        ),
      ),
    );
  }
}
