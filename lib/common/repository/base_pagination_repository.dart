import 'package:inflearn_code_factory/product/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/product/model/pagination_params.dart';

// 인터페이스
// - T: RestaurantModel, RatingModel
abstract class IBasePaginationRepository<T> {
  Future<CursorPaginationModel<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
