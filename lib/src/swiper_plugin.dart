import 'package:flutter/widgets.dart';
import 'flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// plugin to display swiper components
///
abstract class SwiperPlugin {
  const SwiperPlugin();

  Widget build(BuildContext context, SwiperPluginConfig config);
}

class SwiperPluginConfig {
  final int activeIndex;
  final int itemCount;
  final PageIndicatorLayout indicatorLayout;
  final Axis scrollDirection;
  final bool loop;
  final bool outer;
  final PageController? pageController;
  final SwiperController controller;
  final SwiperLayout? layout;

  const SwiperPluginConfig(
      {
        this.activeIndex = 0,
        this.itemCount = 0,
        this.indicatorLayout = PageIndicatorLayout.NONE,
        this.outer = false,
        required this.scrollDirection,
        required this.controller,
        this.pageController,
        this.layout,
        this.loop = false
      });
}

class SwiperPluginView extends StatefulWidget {
  final SwiperPlugin plugin;
  final SwiperPluginConfig config;

  const SwiperPluginView(this.plugin, this.config, {Key? key}) : super(key: key);

  @override
  State<SwiperPluginView> createState() => _SwiperPluginViewState();
}

class _SwiperPluginViewState extends State<SwiperPluginView> {
  @override
  Widget build(BuildContext context) {
    return widget.plugin.build(context, widget.config);
  }
}
