// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResponseData<T> _$HttpResponseDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    HttpResponseData<T>(
      code: const SafeIntConverter().fromJson(json['code']),
      message: json['message'] as String,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$HttpResponseDataToJson<T>(
  HttpResponseData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': const SafeIntConverter().toJson(instance.code),
      'message': instance.message,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
