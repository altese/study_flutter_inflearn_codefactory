import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CursorPaginationModel<T> {
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
