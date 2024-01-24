import 'package:flutter/material.dart';
import 'package:inflearn_code_factory/restaurant/component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RestaurantCard(
          image: Image.asset(
            'asset/img/food/pcc-01.png',
            fit: BoxFit.cover,
          ),
          name: '피짱즈',
          tags: const ['피요', '피코', '피쿠'],
          ratingCount: 400,
          deliveryTime: 15,
          deliveryFee: 18000,
          ratings: 4.4,
        ),
      ),
    );
  }
}
