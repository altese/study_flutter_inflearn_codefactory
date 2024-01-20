import 'package:flutter/material.dart';

/*
  DefaultLayout의 쓰임새
  - 모든 페이지에서 기본적으로 써야 하는 기능이 있다면 이 곳에 정의한다.
  - ex. initState에서 API 요청을 모든 페이지에서 하고 싶을 때 
*/

class DefaultLayout extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;

  const DefaultLayout({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
  });

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: widget.child,
    );
  }
}
