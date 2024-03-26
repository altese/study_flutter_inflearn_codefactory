import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inflearn_code_factory/common/component/pagination_list_view.dart';
import 'package:inflearn_code_factory/product/component/product_card.dart';
import 'package:inflearn_code_factory/product/model/product_model.dart';
import 'package:inflearn_code_factory/product/provider/product_provider.dart';
import 'package:inflearn_code_factory/restaurant/view/restaurant_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            // 상세페이지로 가기
            context.goNamed(
              RestaurantDetailScreen.routeName,
              pathParameters: {'rid': model.restaurant.id},
            );
          },
          child: ProductCard.fromProductModel(model: model),
        );
      },
    );
  }
}
