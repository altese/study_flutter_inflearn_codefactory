import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/common/provider/pagination_provider.dart';
import 'package:inflearn_code_factory/restaurant/model/restaurant_model.dart';
import 'package:inflearn_code_factory/restaurant/repository/restaurant_repository.dart';

// for 캐싱
// - restaurantProvider에 있는 데이터를 디테일 페이지에서도 쓰기 때문에 이미 있는 데이터는 restaurantProvider에서 가져온다.
final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  // 데이터가 없으면 null
  if (state is! CursorPaginationModel) {
    return null;
  }

  // 데이터가 있으면 해당 데이터를 찾아서 리턴
  return state.data.firstWhere((element) => element.id == id);
});

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
class RestaurantStateNotifier
    extends PaginationStateProvider<RestaurantModel, RestaurantRepository> {
  // 슈퍼클래스에서 상속받으므로 CursorPaginationLoading
  RestaurantStateNotifier({required super.repository});

  // PaginationStateProvider 슈퍼클래스에서 상속받으므로 paginate() 삭제

  void getDetail({
    required String id,
  }) async {
    // CursorPaginationModel이 아닐 때 (데이터가 없을 때)
    // - 데이터를 가져오는 요청
    if (state is! CursorPaginationModel) {
      await paginate();
    }

    // 여전히 CursorPaginationModel이 아닐 때
    // - 서버에서 오류가 난 경우
    if (state is! CursorPaginationModel) {
      return;
    }

    // CursorPaginationModel일 때
    final pState = state as CursorPaginationModel;

    final resp = await repository.getRestaurantDetail(id: id);

    // 첫번째 요청일 때 해당 id의 pState.data는 RestaurantModel -> RestaurantDetailModel인 resp로 대체
    state = pState.copyWith(
      data: pState.data
          .map<RestaurantModel>((e) => e.id == id ? resp : e)
          .toList(),
    );
  }
}
