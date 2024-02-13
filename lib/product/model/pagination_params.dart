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

  // count를 유지한 채로 after만 바꾸거나 after를 유지한 채로 count를 바꾸고 싶은 상황에 copyWith 사용
  PaginationParams copyWith({
    String? after,
    int? count,
  }) {
    return PaginationParams(
      after: after ?? this.after,
      count: count ?? this.count,
    );
  }

  // fromJson이 딱히 중요치 않음.
  // 값들을 API 응답으로부터 받는 게 아니라 직접 넣어서 요청을 보내는 것이기 때문
  // => toJson이 더 중요함.
  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
