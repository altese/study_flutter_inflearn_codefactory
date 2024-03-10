import 'package:flutter/widgets.dart';
import 'package:inflearn_code_factory/common/provider/pagination_provider.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationStateProvider provider,
  }) {
    // 일반화하기
    //  if (controller.offset > controller.position.maxScrollExtent - 300) {
    //   ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    // }

    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(fetchMore: true);
    }
  }
}
