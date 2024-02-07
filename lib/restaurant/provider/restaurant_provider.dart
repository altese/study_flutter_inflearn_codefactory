import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/product/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/restaurant/repository/restaurant_repository.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

// 현재 코드의 문제점
// 페이지네이션을 하려면 CursorPaginationModel 안의 List<RestaurantModel>만 가지고 있을 게 아니라
// meta 데이터도 가지고 있어야 hasMore을 확인하고 다음 요청을 보낼지 말지 판단할 수 있다.
class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
    //*** super constructor 안에는 CursorPaginationModel가 아직 로딩 상태라는 값을 넣어 줘야 함
  }) : super(CursorPaginationLoading()) {
    // RestaurantStateNotifier가 생성되자마자 페이지네이션 요청을 해야 한다.
    // 값을 가지고 있어야 하기 때문에
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();

    state = resp;
  }
}
