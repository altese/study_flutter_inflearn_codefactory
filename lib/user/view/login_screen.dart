import 'package:flutter/material.dart';
import 'package:inflearn_code_factory/common/component/custom_text_form_field.dart';
import 'package:inflearn_code_factory/common/const/colors.dart';
import 'package:inflearn_code_factory/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: const Color(0xFFd5f3ef),
      // 키보드가 올라올 때 오류 나지 않도록 SingleChildScrollView로 감싼다.
      child: LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            // 위젯들 정렬을 위해 constraints
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Title(),
                        SizedBox(height: 5),
                        _SubTitle(),
                      ],
                    ),
                    Image.asset(
                      'asset/img/misc/pochacco.png',
                      width: MediaQuery.of(context).size.width / 3 * 2,
                    ),
                    Column(
                      children: [
                        CustomTextFormField(
                          hintText: '이메일을 입력해 주세요.',
                          onChanged: (String value) {},
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: '비밀번호를 입력해 주세요.',
                          onChanged: (String value) {},
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: POINT_COLOR_YELLOW,
                              elevation: 0.5,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              '로그인',
                              style: TextStyle(
                                color: BODY_TEXT_COLOR,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: PRIMARY_COLOR),
                          onPressed: () {},
                          child: const Text(
                            '회원가입',
                            style: TextStyle(
                              color: PRIMARY_COLOR,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'POCHACCO',
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '포차코는 호기심이 많고 산책을 좋아하는 강아지예요.\n그럼 포차코를 만나러 가볼까요?',
      style: TextStyle(
        fontSize: 16,
        // color: BODY_TEXT_COLOR,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
