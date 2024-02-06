import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/const/data.dart';
import 'package:inflearn_code_factory/common/dio/dio.dart';
import 'package:inflearn_code_factory/product/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/restaurant/component/restaurant_card.dart';
import 'package:inflearn_code_factory/restaurant/model/restaurant_model.dart';
import 'package:inflearn_code_factory/restaurant/repository/restaurant_repository.dart';
import 'package:inflearn_code_factory/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<CursorPaginationModel<RestaurantModel>>(
          future: ref.watch(restaurantRepositoryProvider).paginate(),
          builder: (context,
              AsyncSnapshot<CursorPaginationModel<RestaurantModel>> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);

              return ListView.separated(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (_, index) {
                  final parsedItem2 = snapshot.data!.data[index];

                  // 기본 Constructor를 사용해 item을 class로 parsing
                  // final parsedItem = RestaurantModel(
                  //   id: item['id'],
                  //   name: item['name'],
                  //   thumbUrl: item['thumbUrl'],
                  //   tags: List<String>.from(item['tags']),
                  //   priceRange: RestaurantPriceRange.values.firstWhere(
                  //     (element) => element.name == item['priceRange'],
                  //   ),
                  //   ratings: item['ratings'],
                  //   ratingsCount: item['ratingsCount'],
                  //   deliveryTime: item['deliveryTime'],
                  //   deliveryFee: item['deliveryFee'],
                  // );

                  // 개선: factory Constructor를 사용해 parsing
                  // final RestaurantModel parsedItem2 =
                  //     RestaurantModel.fromJson(item);

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
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
