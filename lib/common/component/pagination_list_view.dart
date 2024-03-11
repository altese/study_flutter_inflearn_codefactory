import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/common/model/model_with_id.dart';
import 'package:inflearn_code_factory/common/provider/pagination_provider.dart';
import 'package:inflearn_code_factory/common/utils/pagination_utils.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

// <T extends IModelWithId> ***
class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  // *** provider를 일반화하는 변수
  final StateNotifierProvider<PaginationStateProvider, CursorPaginationBase>
      provider;

  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    super.key,
    required this.provider,
    required this.itemBuilder,
  });

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // 컨트롤러의 특정 값이 바뀔 때마다 scrollListener 실행
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(
      controller: controller,
      // widget.provider: restaurantProvider
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(widget.provider);

    // 첫 로딩
    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 에러
    if (data is CursorPaginationError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(forceRefetch: true);
            },
            child: const Text('새로 고침'),
          ),
        ],
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    // <T> ***
    final cp = data as CursorPaginationModel<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1, // 로딩바 추가하기 위해 + 1
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: cp is CursorPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text('데이터가 없습니다.'),
              ),
            );
          }

          // itemBuilder 안에 있으므로 index가 끝날 때까지 반복 실행
          final pItem = cp.data[index];

          return widget.itemBuilder(context, index, pItem);
        },
        // 아이템 사이에 들어가는 위젯
        separatorBuilder: (_, index) {
          return const SizedBox(height: 15);
        },
      ),
    );
  }
}
