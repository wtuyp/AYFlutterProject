import 'package:app/utility/json/safe_num_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model_enum_define.dart';
part 'person_model.g.dart';

@JsonSerializable(
  converters: [SafeNumConverter(), SafeIntConverter()],
)
class PersonModel {
  final int? id;
  final String? name;
  final String? nickname;
  final String? avatar;
  final int? age;
  final Gender? gender;
  final String? email;
  final String? phone;
  final String? birthday;
  final String? idNumber;
  final num? height;
  final num? weight;

  PersonModel({
    this.id,
    this.name,
    this.nickname,
    this.avatar,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.birthday,
    this.idNumber,
    this.height,
    this.weight,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => _$PersonModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}