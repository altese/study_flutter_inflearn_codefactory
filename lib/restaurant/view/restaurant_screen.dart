import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/restaurant/component/restaurant_card.dart';
import 'package:inflearn_code_factory/restaurant/provider/restaurant_provider.dart';
import 'package:inflearn_code_factory/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // 컨트롤러의 특정 값이 바뀔 때마다 scrollListener 실행
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜되는 위치라면 추가 요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // FutureBuilder 대체
    final data = ref.watch(restaurantProvider);

    // 첫 로딩
    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 에러
    if (data is CursorPaginationError) {
      return Center(child: Text(data.message));
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    final cp = data as CursorPaginationModel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1, // 로딩바 추가하기 위해 + 1
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: data is CursorPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text('데이터가 없습니다.'),
              ),
            );
          }

          final parsedItem2 = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(
                    id: parsedItem2.id,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(model: parsedItem2),
          );
        },
        // 아이템 사이에 들어가는 위젯
        separatorBuilder: (_, index) {
          return const SizedBox(height: 15);
        },
      ),
    );
  }
}
