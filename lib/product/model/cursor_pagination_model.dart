import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// 클래스로 상태 구분하기: 무조건 Base로 만듦
// - 아무 기능을 하지 않는 추상 클래스지만 CursorPaginationModel의 타입을 판단했을 때
// CursorPaginationBase가 나온다는 점이 중요함.
// - CursorPaginationModel은 데이터가 잘 있을 때
// - CursorPaginationError는 에러가 났을 때
// - CursorPaginationLoading은 로딩 중일 때
abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

// 아무 구현 없어도 됨! CursorPaginationLoading 타입인 것만으로도 로딩 중이라는 의미니까
class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(genericArgumentFactories: true)
class CursorPaginationModel<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  // 리스트의 타입만 유동적으로 바뀐다. -> 제너릭으로 받아오는 것으로 해결
  final List<T> data;

  CursorPaginationModel({
    required this.meta,
    required this.data,
  });

  // T 제네릭이 어떤 타입으로 들어올지 알 수 없기 때문에 외부에서 전환되는 방법을 알려줘야 한다.
  factory CursorPaginationModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationModelFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

// 새로고침할 때
// : 기존 데이터 리셋 + 추가 데이터
// meta, data가 이미 존재한다는 가정 하에 사용하기 때문에 CursorPaginationModel 상속
// CursorPaginationRefetching도 Base의 서브 클래스
class CursorPaginationRefetching<T> extends CursorPaginationModel<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서 추가 데이터 요청할 때
// : 기존 데이터 유지 + 추가 데이터
class CursorPaginationFetchingMore<T> extends CursorPaginationModel<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
