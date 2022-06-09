
// import 'dart:async';
//
// import 'package:flutter/services.dart';
//
// class FlutterSwiper {
//   static const MethodChannel _channel = MethodChannel('flutter_swiper');
//
//   static Future<String?> get platformVersion async {
//     final String? version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }

library flutter_swiper;

export 'src/swiper.dart';
export 'src/swiper_pagination.dart';
export 'src/swiper_control.dart';
export 'src/swiper_controller.dart';
export 'src/swiper_plugin.dart';