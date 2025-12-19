// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      id: const SafeIntConverter().fromJson(json['id']),
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      avatar: json['avatar'] as String?,
      age: const SafeIntConverter().fromJson(json['age']),
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      birthday: json['birthday'] as String?,
      idNumber: json['idNumber'] as String?,
      height: const SafeNumConverter().fromJson(json['height']),
      weight: const SafeNumConverter().fromJson(json['weight']),
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<dynamic, int>(
          instance.id, const SafeIntConverter().toJson),
      'name': instance.name,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'age': _$JsonConverterToJson<dynamic, int>(
          instance.age, const SafeIntConverter().toJson),
      'gender': _$GenderEnumMap[instance.gender],
      'email': instance.email,
      'phone': instance.phone,
      'birthday': instance.birthday,
      'idNumber': instance.idNumber,
      'height': _$JsonConverterToJson<dynamic, num>(
          instance.height, const SafeNumConverter().toJson),
      'weight': _$JsonConverterToJson<dynamic, num>(
          instance.weight, const SafeNumConverter().toJson),
    };

const _$GenderEnumMap = {
  Gender.unknown: 'unknown',
  Gender.male: 'male',
  Gender.female: 'female',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
