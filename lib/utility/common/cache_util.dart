import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// 缓存工具类
class CacheUtil {

  /// 格式化缓存大小
  /// [size] 缓存大小（单位：字节）
  static String formatSize(int size) {
    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;

    if (size < kb) return '${size}B';
    if (size < mb) return '${(size / kb).toStringAsFixed(2)}KB';
    if (size < gb) return '${(size / mb).toStringAsFixed(2)}MB';
    return '${(size / gb).toStringAsFixed(2)}GB';
  }

  /// 获取缓存大小（单位：字节）
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

  /// 递归计算缓存目录大小（单位：字节）
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
