import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/const/data.dart';
import 'package:inflearn_code_factory/common/dio/dio.dart';
import 'package:inflearn_code_factory/common/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/common/model/pagination_params.dart';
import 'package:inflearn_code_factory/common/repository/base_pagination_repository.dart';
import 'package:inflearn_code_factory/product/model/product_model.dart';
import 'package:retrofit/http.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository = ProductRepository(dio, baseUrl: 'http://$ip/product');

    return repository;
  },
);

// http://$ip/product
@RestApi()
abstract class ProductRepository
    implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPaginationModel<ProductModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
