import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inflearn_code_factory/common/component/pagination_list_view.dart';
import 'package:inflearn_code_factory/restaurant/component/restaurant_card.dart';
import 'package:inflearn_code_factory/restaurant/provider/restaurant_provider.dart';
import 'package:inflearn_code_factory/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      // model: final parsedItem2 = cp.data[index];
      itemBuilder: <RestaurantModel>(_, index, model) => GestureDetector(
        onTap: () {
          context.goNamed(
            RestaurantDetailScreen.routeName,
            pathParameters: {'rid': model.id},
          );
          // context.go('/restaurant/${model.id}');
        },
        child: RestaurantCard.fromModel(model: model),
      ),
    );
  }
}
