import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/common/model/model_with_id.dart';
import 'package:inflearn_code_factory/common/model/pagination_params.dart';
import 'package:inflearn_code_factory/common/repository/base_pagination_repository.dart';

class PaginationStateProvider<
        // T: RatingModel, RestaurantModel
        T extends IModelWithId,
        // U: RestaurantRatingRepository, RestaurantRepository
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationStateProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    // 가져올 때 개수
    int fetchCount = 20,
    // true - 데이터 추가로 가져오기
    // false - 새로고침: 데이터를 가져와서 현재 상태에 덮어 씌움
    bool fetchMore = false,
    // 강제로 다시 로딩하기: 데이터를 싹 지우고 로딩
    // true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      // State는 5가지 경우의 수를 가짐
      // 1) CursorPagination - 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터가 로딩 중인 상태 (현재 캐시 없음)
      // 3) CursorPaginationError - 에러
      // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올 때
      // 5) CursorPaginationFetchingMore - 추가 데이터를 요청할 때

      // 바로 return해야 하는 상황 두 가지
      // 1) hasMore == false (다음 데이터가 없으므로 추가 요청을 하지 않고 return)
      // 2) 로딩 중: fetchMore == true일 때 (추가 데이터를 요청해서 로딩 중일 때)
      //    추가 데이터를 요청 중에 다시 실행하면 똑같은 데이터를 또 불러오기 때문에 return해준다.

      // 첫 요청에는 반드시 CursorPaginationLoading이 들어가 있다.
      // 요청을 한 번 이상 해서 데이터를 가지고 있는 상태면서 forceRefetch가 false일 때
      if (state is CursorPaginationModel && !forceRefetch) {
        final pState = state as CursorPaginationModel;

        // 1) haseMore == false
        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      // 2) fetchMore == true
      if (fetchMore && (isRefetching || isLoading || isFetchingMore)) {
        return;
      }

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore: 데이터를 추가로 요청하는 상황
      if (fetchMore) {
        // fetchMore는 현재 데이터가 있는 상태로 추가 요청이기 때문에 state의 타입이 무조건 CursorPaginationModel일 수밖에 없다.
        final pState = (state as CursorPaginationModel<T>);

        // 현재 상태의 데이터를 유지한 채로 CursorPaginationFetchingMore 타입으로 바꿀 수 있다.
        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        //  pagination을 위해서는 id가 필요!
        paginationParams =
            paginationParams.copyWith(after: pState.data.last.id);

        // else: 데이터를 처음부터 가져오는 상황
        // - 맨 처음 데이터를 요청할 때
        // - 강제로 새로고침할 때
      } else {
        // 기존 데이터가 있다면 데이터를 유지한 채 Fetch(API 요청)를 진행
        if (state is CursorPaginationModel && !forceRefetch) {
          final pState = state as CursorPaginationModel<T>;

          state = CursorPaginationRefetching<T>(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      // 요청 보내기
      final resp =
          await repository.paginate(paginationParams: paginationParams);

      // 기존 데이터를 유지하는 경우
      if (state is CursorPaginationFetchingMore) {
        final pState = (state as CursorPaginationFetchingMore<T>);

        // 기존 데이터(pState.data)와 새로 받아온 데이터(resp.data)를 합친다.
        state = resp.copyWith(data: [...pState.data, ...resp.data]);

        // 기존 데이터를 유지하지 않는 경우
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
