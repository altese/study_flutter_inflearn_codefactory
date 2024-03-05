import 'package:inflearn_code_factory/common/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/common/model/model_with_id.dart';
import 'package:inflearn_code_factory/common/model/pagination_params.dart';

// 인터페이스
// - T: RestaurantModel, RatingModel
abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPaginationModel<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
