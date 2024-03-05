import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/common/provider/pagination_provider.dart';
import 'package:inflearn_code_factory/rating/model/rating_model.dart';
import 'package:inflearn_code_factory/restaurant/repository/restaurant_rating_repository.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restaurantRatingRepositoryProvider(id: id));

  return RestaurantRatingStateNotifier(repository: repo);
});

class RestaurantRatingStateNotifier
    extends PaginationStateProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingStateNotifier({required super.repository});

  // PaginationStateProvider 슈퍼클래스에서 상속받으므로 paginate() 삭제
}
