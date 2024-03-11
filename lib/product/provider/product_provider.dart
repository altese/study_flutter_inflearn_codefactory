import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/common/provider/pagination_provider.dart';
import 'package:inflearn_code_factory/product/model/product_model.dart';
import 'package:inflearn_code_factory/product/provider/product_repository.dart';

final productProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(productRepositoryProvider);
    final notifier = ProductStateNotifier(repository: repository);

    return notifier;
  },
);

class ProductStateNotifier
    extends PaginationStateProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({required super.repository});
}
