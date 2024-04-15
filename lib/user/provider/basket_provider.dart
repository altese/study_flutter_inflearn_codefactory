import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/product/model/product_model.dart';
import 'package:inflearn_code_factory/user/model/basket_item_model.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
  (ref) {
    return BasketProvider();
  },
);

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    // 장바구니에 없는 상품을 추가할 때
    // 있는 상품을 추가할 때: count + 1

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exists) {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count + 1) : e)
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(product: product, count: 1),
      ];
    }
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    // true면 count와 관계없이 삭제
    bool isDelete = false,
  }) async {
    // 1) 장바구니에 있는 상품일 때
    // - count가 1보다 크면 -1
    // - count가 1이면 삭제

    // 2) 장바구니에 없는 상품일 때
    // - return

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (!exists) return;

    final existingProduct = state.firstWhere(
      (e) => e.product.id == product.id,
    );

    if (existingProduct.count == 1 || isDelete) {
      state = state.where((e) => e.product.id != product.id).toList();
    } else {
      state = state
          .map(
            (e) => e.product.id == product.id
                ? e.copyWith(
                    count: e.count - 1,
                  )
                : e,
          )
          .toList();
    }
  }
}
