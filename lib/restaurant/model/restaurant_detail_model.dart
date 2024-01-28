import 'package:inflearn_code_factory/common/const/data.dart';
import 'package:inflearn_code_factory/restaurant/model/restaurant_model.dart';

// RestaurantDetailModel은 RestaurantModel에서 필드 몇 개가 추가되었을 뿐이므로 상속을 이용한다.
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: json['thumbUrl'],
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
        (element) => element.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      // *** List<Map<String, dynamic>> 값을 List<RestaurantProductModel>로 변환
      products: json['products']
          .map<RestaurantProductModel>((x) => RestaurantProductModel(
                id: x['id'],
                name: x['name'],
                imgUrl: 'http://$ip${json['imgUrl']}',
                detail: x['detail'],
                price: x['price'],
              ))
          .toList(),
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });
}
