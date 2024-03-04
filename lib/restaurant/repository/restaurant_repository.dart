import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn_code_factory/common/const/data.dart';
import 'package:inflearn_code_factory/common/dio/dio.dart';
import 'package:inflearn_code_factory/common/repository/base_pagination_repository.dart';
import 'package:inflearn_code_factory/product/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/product/model/pagination_params.dart';
import 'package:inflearn_code_factory/restaurant/model/restaurant_detail_model.dart';
import 'package:inflearn_code_factory/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repository;
  },
);

// IBasePaginationRepository: T 제너릭을 여기서 정해줌
@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPaginationModel<RestaurantModel>> paginate({
    // 파라미터 설정
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id,
  });
}
