import 'package:flutter/material.dart';

/*
  DefaultLayout의 쓰임새
  - 모든 페이지에서 기본적으로 써야 하는 기능이 있다면 이 곳에 정의한다.
  - ex. initState에서 API 요청을 모든 페이지에서 하고 싶을 때 
*/

class DefaultLayout extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const DefaultLayout({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: renderAppBar(widget.title),
      body: widget.child,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  AppBar? renderAppBar(String? title) {
    // title이 없으면 앱바도 없도록
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(title),
      );
    }
  }
}
