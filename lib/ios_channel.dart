import 'package:flutter/services.dart';

class IOSChannel {
  static const _platform = MethodChannel('dev.shoryu.native_connection');

  Future<String> getBatteryLevel() async {
    return await _platform.invokeMethod('getBatteryLevel');
  }
}