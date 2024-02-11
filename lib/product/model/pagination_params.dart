import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final String? after;
  final int? count;

  const PaginationParams({
    this.after,
    this.count,
  });

  // fromJson이 딱히 중요치 않음.
  // 값들을 API 응답으로부터 받는 게 아니라 직접 넣어서 요청을 보내는 것이기 때문
  // => toJson이 더 중요함.
  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
