import 'package:flutter/foundation.dart';
import 'dart:convert';

/// 打印格式化的 JSON 数据
void printPrettyJson(dynamic json, {String tag = 'JSON'}) {
  if (kReleaseMode) {
    return;
  }

  DateTime now = DateTime.now();

  final stackTrace = StackTrace.current;
  String line = stackTrace.toString().split('\n')[1]; // 取调用位置的行
  line = line.split('  ').last;

  try {
    const encoder = JsonEncoder.withIndent('  '); // 2空格缩进
    final prettyJson = encoder.convert(json);
    print('$now $line\n$tag: $prettyJson');
  } catch (e) {
    print('$now $line\n$tag: $json, 无法打印: $e');
  }
}
