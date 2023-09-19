import 'package:flutter/services.dart';

class IOSMethodChannel {
  const IOSMethodChannel._();

  static const _platform = MethodChannel('dev.shoryu.native_connection');

  static Future<int> getBatteryLevel() async {
    return await _platform.invokeMethod('getBatteryLevel');
  }

  static Future<String> getSimpleString() async {
    return await _platform.invokeMethod('getSimpleString');
  }

  static Future<bool> getSimpleBool() async {
    const arg = true;
    return await _platform.invokeMethod('getSimpleBool', arg);
  }

  static Future<List<int>> getSimpleList() async {
    final simpleList = await _platform.invokeListMethod('getSimpleList');
    if (simpleList == null) {
      return [];
    }

    final result = <int>[];
    for (final element in simpleList) {
      if (element is int) {
        result.add(element);
      }
    }
    return result;
  }

  static Future<Map<String, int>> getSimpleMap() async {
    final simpleMap = await _platform.invokeMapMethod('getSimpleMap');
    if (simpleMap == null) {
      return <String, int>{};
    }

    final result = <String, int>{};
    simpleMap.forEach((key, value) {
      if (key is String && value is int) {
        result.addAll({key: value});
      }
    });
    return result;
  }
}
