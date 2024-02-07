import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/restaurant/component/restaurant_card.dart';
import 'package:inflearn_code_factory/restaurant/provider/restaurant_provider.dart';
import 'package:inflearn_code_factory/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FutureBuilder 대체
    final data = ref.watch(restaurantProvider);

    // 임시 예외처리!: 개선 예정
    if (data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          itemCount: data.length,
          itemBuilder: (_, index) {
            final parsedItem2 = data[index];

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
}
