
import 'package:json_annotation/json_annotation.dart';

/// 安全的数字转换器，用于将 JSON 数据转换为数字类型。
/// 如果 JSON 数据不是数字类型或无法解析为数字，则返回默认值。
class SafeNumConverter extends JsonConverter<num, dynamic> {
  final num defaultValue;

  const SafeNumConverter({this.defaultValue = -1});

  @override
  num fromJson(dynamic json) {
    if (json is num) {
      return json;
    }
    if (json is String) {
      try {
        return num.parse(json);
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  @override
  dynamic toJson(num object) {
    return object;
  }
}

class SafeIntConverter extends JsonConverter<int, dynamic> {
  final int defaultValue;

  const SafeIntConverter({this.defaultValue = -1});

  @override
  int fromJson(dynamic json) {
    if (json is int) {
      return json;
    }
    if (json is String) {
      try {
        return int.parse(json);
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  @override
  dynamic toJson(int object) {
    return object;
  }
}

class SafeDoubleConverter extends JsonConverter<double, dynamic> {
  final double defaultValue;

  const SafeDoubleConverter({this.defaultValue = -1});

  @override
  double fromJson(dynamic json) {
    if (json is double) {
      return json;
    }
    if (json is String) {
      try {
        return double.parse(json);
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  @override
  dynamic toJson(num object) {
    return object;
  }
}
