import 'package:json_annotation/json_annotation.dart';

part 'base_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponseModel<T> {
  @JsonKey(name: 'response')
  final ApiResponseInfo responseInfo;
  final T? data;
  BaseResponseModel({required this.responseInfo, this.data});
  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseModelToJson(this, toJsonT);
}

@JsonSerializable()
class ApiResponseInfo {
  final int code;
  final String message;

  ApiResponseInfo({required this.code, required this.message});

  factory ApiResponseInfo.fromJson(Map<String, dynamic> json) => _$ApiResponseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseInfoToJson(this);
}
