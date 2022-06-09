#import "FlutterSwiperPlugin.h"
#if __has_include(<flutter_swiper/flutter_swiper-Swift.h>)
#import <flutter_swiper/flutter_swiper-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_swiper-Swift.h"
#endif

@implementation FlutterSwiperPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSwiperPlugin registerWithRegistrar:registrar];
}
@end
