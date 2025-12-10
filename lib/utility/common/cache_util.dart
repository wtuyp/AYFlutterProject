import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// 基于SharedPreferences键值对数据持久化操作
class CacheUtil {
  /// 保存JSON数据
  static Future<bool> saveJson(String key, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, jsonEncode(value));
  }

  /// 获取JSON数据
  static Future<Map<String, dynamic>?> getJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      // CLog.d("cache", "JSON解析错误: $e");
      return null;
    }
  }

  /// 保存JSON列表数据
  static Future<bool> saveJsonList(
      String key, List<Map<String, dynamic>> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, jsonEncode(value));
  }

  /// 获取JSON列表数据
  static Future<List<dynamic>?> getJsonList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(key) ?? '');
  }

  // 保存字符串数据
  static Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  // 获取字符串数据
  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  // 保存布尔值数据
  static Future<bool> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  // 获取布尔值数据
  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // 保存整数数据
  static Future<bool> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  // 获取整数数据
  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // 保存双精度浮点数数据
  static Future<bool> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  // 获取双精度浮点数数据
  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  // 保存字符串列表数据
  static Future<bool> saveStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  // 获取字符串列表数据
  static Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  // 通用获取数据
  static Future<Object?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  // 删除指定键的数据
  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  // 清空所有数据
  static Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  // 获取所有Key
  static Future<Set<String>> getKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }

  /// 获取缓存大小
  static Future<int> getCacheSize() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        return await _reduce(tempDir);
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// 清理缓存
  static Future<bool> clearCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await _delete(tempDir);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// 递归计算缓存目录大小
  static Future<int> _reduce(FileSystemEntity file) async {
    if (file is File) {
      return await file.length();
    } else if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      int total = 0;
      for (final child in children) {
        total += await _reduce(child);
      }
      return total;
    }
    return 0;
  }

  /// 递归删除缓存目录
  static Future<void> _delete(FileSystemEntity file) async {
    if (file is File) {
      await file.delete();
    } else if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final child in children) {
        await _delete(child);
      }
    }
  }
}
