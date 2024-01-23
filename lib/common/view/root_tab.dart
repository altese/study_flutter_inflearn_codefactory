import 'package:flutter/material.dart';
import 'package:inflearn_code_factory/common/const/colors.dart';
import 'package:inflearn_code_factory/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '포차코의 생활',
      backgroundColor: BG_COLOR_GREEN,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: POINT_COLOR_PURPLE,
        unselectedItemColor: PLACEHOLDER_TEXT_COLOR,
        // shifted로 선택 시 선택된 탭바 item이 커지고 나머지가 옆으로 밀림, 글자도 사라짐
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: '프로필',
          ),
        ],
      ),
      child: const Center(
        child: Text('root tab'),
      ),
    );
  }
}
