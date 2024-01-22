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
      borderSide: BorderSide(color: Colors.white, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    );

    return TextFormField(
      cursorColor: POINT_COLOR_PURPLE,
      // 비밀번호 입력 때만 사용
      obscureText: obscureText,
      // 자동으로 포커즈됨
      autofocus: autofocus,
      // 값이 바뀔 때 실행되는 콜백
      onChanged: onChanged,
      decoration: InputDecoration(
        // 텍스트 필드 안의 패딩
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        hintText: hintText,
        errorText: errorText,
        hintStyle:
            const TextStyle(color: PLACEHOLDER_TEXT_COLOR, fontSize: 14.0),
        fillColor: INPUT_BG_COLOR,
        filled: true,

        /* 
          inputBorder는 여러 가지의 상태가 있다.
          선택된 상태, 선택되지 않은 상태, 활성화, 비활성화
        */
        // 활성화(텍스트 입력을 막아두지 않은 것)되지 않았을 때의 스타일
        border: baseBorder,
        // 활성화되었을 때의 스타일
        enabledBorder: baseBorder,
        // 선택한 상태일 때의 border 스타일
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(color: POINT_COLOR_PURPLE),
        ),
      ),
    );
  }
}
