// id 값을 가진 모델들은 모두 이 인터페이스를 구현함
// pagination을 할 모델들에 아래 인터페이스 구현
// - RestaurantModel, RatingModel
abstract class IModelWithId {
  final String id;

  IModelWithId({required this.id});
}
