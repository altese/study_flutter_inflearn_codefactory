import 'package:flutter/material.dart';
import 'package:inflearn_code_factory/common/const/colors.dart';
import 'package:inflearn_code_factory/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

// vsync: this를 위해 Mixin
class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);

    // 탭바 컨트롤러에 변화가 있을 때마다 함수 실행
    // 탭바 인덱스 바꾸기
    tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = tabController.index;
    });
  }

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
          // tabController와 bottomNavigationBar 연결
          // 탭바뷰 이동
          tabController.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: '프로필',
          ),
        ],
      ),
      child: TabBarView(
        // 좌우 스크롤 시 화면 전환이 되지 않도록
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          Center(child: Text('홈')),
          Center(child: Text('음식')),
          Center(child: Text('주문')),
          Center(child: Text('프로필')),
        ],
      ),
    );
  }
}
