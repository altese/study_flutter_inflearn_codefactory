import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/restaurant/model/restaurant_model.dart';
import 'package:inflearn_code_factory/restaurant/repository/restaurant_repository.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super([]) {
    // RestaurantStateNotifier가 생성되자마자 페이지네이션 요청을 해야 한다.
    // 값을 가지고 있어야 하기 때문에
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();

    state = resp.data;
  }
}
