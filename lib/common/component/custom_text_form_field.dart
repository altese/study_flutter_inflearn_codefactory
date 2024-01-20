import 'package:flutter/material.dart';
import 'package:inflearn_code_factory/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? errorText;

  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText, // 비밀번호 입력 때만 사용
      autofocus: autofocus, // 자동으로 포커즈됨
      onChanged: onChanged, // 값이 바뀔 때 실행되는 콜백
      decoration: InputDecoration(
        // 텍스트 필드 안의 패딩
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
        fillColor: INPUT_BG_COLOR,
        filled: true,

        // inputBorder는 여러 가지의 상태가 있다.
        // 선택된 상태, 선택되지 안은 상태, 활성화, 비활성화
        border: baseBorder, // 모든 Input 상태의 기본 스타일 세팅
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR),
        ), // 선택한 상태일 때의 border 스타일
      ),
    );
  }
}
