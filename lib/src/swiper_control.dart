import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperControl extends SwiperPlugin {
  ///IconData for previous
  final IconData iconPrevious;

  ///iconData fopr next
  final IconData iconNext;

  ///icon size
  final double size;

  ///图标正常颜色，默认情况下主题为[ThemeData.primaryColor]。
  final Color? color;

  ///如果在Swiper上设置loop=false，则在Swiper获取最后一张幻灯片时将使用此颜色。默认情况下主题为[ThemeData.disabledColor]。
  final Color? disableColor;

  final EdgeInsetsGeometry padding;

  final Key? key;

  const SwiperControl(
      {
        this.iconPrevious = Icons.arrow_back_ios,
        this.iconNext = Icons.arrow_forward_ios,
        this.color,
        this.disableColor,
        this.key,
        this.size = 30.0,
        this.padding = const EdgeInsets.all(5.0)});

  Widget buildButton(SwiperPluginConfig config, Color color, IconData iconDaga,
      int quarterTurns, bool previous) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (previous) {
          config.controller.previous(animation: true);
        } else {
          config.controller.next(animation: true);
        }
      },
      child: Padding(
          padding: padding,
          child: RotatedBox(
              quarterTurns: quarterTurns,
              child: Icon(
                iconDaga,
                semanticLabel: previous ? "Previous" : "Next",
                size: size,
                color: color,
              ))),
    );
  }

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    ThemeData themeData = Theme.of(context);

    Color color = this.color ?? themeData.primaryColor;
    Color disableColor = this.disableColor ?? themeData.disabledColor;
    Color prevColor;
    Color nextColor;

    if (config.loop) {
      prevColor = nextColor = color;
    } else {
      bool next = config.activeIndex < config.itemCount - 1;
      bool prev = config.activeIndex > 0;
      prevColor = prev ? color : disableColor;
      nextColor = next ? color : disableColor;
    }

    Widget child;
    if (config.scrollDirection == Axis.horizontal) {
      child = Row(
        key: key,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton(config, prevColor, iconPrevious, 0, true),
          buildButton(config, nextColor, iconNext, 0, false)
        ],
      );
    } else {
      child = Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton(config, prevColor, iconPrevious, -3, true),
          buildButton(config, nextColor, iconNext, -3, false)
        ],
      );
    }

    return SizedBox(
      height: double.infinity,
      child: child,
      width: double.infinity,
    );
  }
}
