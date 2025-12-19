// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_paging_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpPagingData<T> _$HttpPagingDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    HttpPagingData<T>(
      pageIndex: json['current'] == null
          ? 1
          : const SafeIntConverter().fromJson(json['current']),
      pageTotal: json['pages'] == null
          ? 1
          : const SafeIntConverter().fromJson(json['pages']),
      pageData:
          (json['records'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
    );

Map<String, dynamic> _$HttpPagingDataToJson<T>(
  HttpPagingData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'current': const SafeIntConverter().toJson(instance.pageIndex),
      'pages': const SafeIntConverter().toJson(instance.pageTotal),
      'records': instance.pageData.map(toJsonT).toList(),
    };
