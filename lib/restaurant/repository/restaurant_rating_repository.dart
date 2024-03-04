import 'package:dio/dio.dart' hide Headers;
import 'package:inflearn_code_factory/common/const/data.dart';
import 'package:inflearn_code_factory/common/dio/dio.dart';
import 'package:inflearn_code_factory/common/repository/base_pagination_repository.dart';
import 'package:inflearn_code_factory/product/model/cursor_pagination_model.dart';
import 'package:inflearn_code_factory/product/model/pagination_params.dart';
import 'package:inflearn_code_factory/rating/model/rating_model.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_rating_repository.g.dart';

// http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPaginationModel<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}

@riverpod
RestaurantRatingRepository restaurantRatingRepository(
  ProviderRef ref, {
  required String id,
}) {
  final dio = ref.watch(dioProvider);
  final repository = RestaurantRatingRepository(
    dio,
    baseUrl: 'http://$ip/restaurant/$id/rating',
  );
  return repository;
}
