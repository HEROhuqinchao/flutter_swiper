import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';

import 'package:transformer_page_view_tv/transformer_page_view.dart';

import 'flutter_page_indicator.dart';

part 'custom_layout.dart';

typedef SwiperOnTap = void Function(int index);

typedef SwiperDataBuilder = Widget Function(BuildContext context, dynamic data, int index);

/// default auto play delay
const int kDefaultAutoplayDelayMs = 3000;

///  Default auto play transition duration (in millisecond)
const int kDefaultAutoplayTransactionDuration = 300;

const int kMaxValue = 2000000000;
const int kMiddleValue = 1000000000;

enum SwiperLayout { DEFAULT, STACK, TINDER, CUSTOM }

class Swiper extends StatefulWidget {
  /// If set true , the pagination will display 'outer' of the 'content' container.
  /// 如果设置为true，分页将显示“outer”容器的“content”。
  final bool outer;

  /// Inner item height, this property is valid if layout=STACK or layout=TINDER or LAYOUT=CUSTOM,
  /// 内部项目高度，如果layout=STACK或layout=TINDER或layout= CUSTOM，此属性有效，
  final double? itemHeight;

  /// Inner item width, this property is valid if layout=STACK or layout=TINDER or LAYOUT=CUSTOM,
  /// 内项宽度，如果layout=STACK或layout=TINDER或layout= CUSTOM，此属性有效
  final double? itemWidth;

  // height of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  // 内部容器的高度，当outer=true时此属性有效，否则内部容器的大小由父部件控制
  final double? containerHeight;
  // width of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  // 内部容器的宽度，当outer=true时此属性有效，否则内部容器的大小由父部件控制
  final double? containerWidth;

  /// Build item on index
  final IndexedWidgetBuilder itemBuilder;

  /// 像Android PageView一样支持转换 ' itemBuilder '和' transformItemBuilder '必须有一个不为空
  final PageTransformer? transformer;

  /// count of the display items
  final int? itemCount;

  final ValueChanged<int>? onIndexChanged;

  ///auto play config
  final bool autoplay;

  ///Duration of the animation between transactions (in millisecond).
  final int autoplayDelay;

  ///disable auto play when interaction
  final bool autoplayDisableOnInteraction;

  ///auto play transition duration (in millisecond)
  final int duration;

  ///horizontal/vertical
  final Axis scrollDirection;

  ///transition curve
  final Curve curve;

  /// 设置为false禁用连续循环模式。
  final bool loop;

  /// 初始幻灯片的索引号。
  /// 如果没有设置，“刷子”是“不受控制的”，这意味着自己管理索引
  /// 如果设置，则“Swiper”为“controlled”，这意味着索引完全由父小部件管理。
  final int index;

  ///Called when tap
  final SwiperOnTap? onTap;

  /// 滑动器分页插件
  final SwiperPlugin? pagination;

  /// 滑动器控制按钮插件
  final SwiperPlugin? control;

  /// 其他插件，您可以自定义自己的插件
  final List<SwiperPlugin>? plugins;

  ///
  final SwiperController? controller;

  final ScrollPhysics? physics;

  ///
  final double viewportFraction;

  /// Build in layouts
  final SwiperLayout layout;

  /// 此值在 layout == SwiperLayout.CUSTOM 有效。
  final CustomLayoutOption? customLayoutOption;

  // This value is valid when viewportFraction is set and < 1.0
  final double? scale;

  // This value is valid when viewportFraction is set and < 1.0
  final double? fade;

  final PageIndicatorLayout indicatorLayout;

  const Swiper({
    required this.itemBuilder,
    this.indicatorLayout = PageIndicatorLayout.NONE,
    ///
    this.transformer,
    required this.itemCount,
    this.autoplay = false,
    this.layout = SwiperLayout.DEFAULT,
    this.autoplayDelay = kDefaultAutoplayDelayMs,
    this.autoplayDisableOnInteraction = true,
    this.duration = kDefaultAutoplayTransactionDuration,
    this.onIndexChanged,
    this.index = 0,
    this.onTap,
    this.control,
    this.loop = true,
    this.curve = Curves.ease,
    this.scrollDirection = Axis.horizontal,
    this.pagination,
    this.plugins,
    this.physics,
    Key? key,
    this.controller,
    this.customLayoutOption,

    /// since v1.0.0
    this.containerHeight,
    this.containerWidth,
    this.viewportFraction = 1.0,
    this.itemHeight,
    this.itemWidth,
    this.outer = false,
    this.scale,
    this.fade,
  })  : assert(itemBuilder != null || transformer != null,
            "itemBuilder and transformItemBuilder must not be both null"),
        assert(
            !loop ||
                ((loop &&
                        layout == SwiperLayout.DEFAULT &&
                        (indicatorLayout == PageIndicatorLayout.SCALE ||
                            indicatorLayout == PageIndicatorLayout.COLOR ||
                            indicatorLayout == PageIndicatorLayout.NONE)) ||
                    (loop && layout != SwiperLayout.DEFAULT)),
            "Only support `PageIndicatorLayout.SCALE` and `PageIndicatorLayout.COLOR`when layout==SwiperLayout.DEFAULT in loop mode"),
        super(key: key);

  factory Swiper.children({
    required List<Widget> children,
    bool autoplay = false,
    required PageTransformer transformer,
    int autoplayDelay = kDefaultAutoplayDelayMs,
    bool reverse = false,
    bool autoplayDisableOnInteraction = true,
    int duration = kDefaultAutoplayTransactionDuration,
    ValueChanged<int>? onIndexChanged,
    int index = 0,
    SwiperOnTap? onTap,
    bool loop = true,
    Curve curve = Curves.ease,
    Axis scrollDirection = Axis.horizontal,
    SwiperPlugin? pagination,
    SwiperPlugin? control,
    List<SwiperPlugin>? plugins,
    SwiperController? controller,
    Key? key,
    CustomLayoutOption? customLayoutOption,
    ScrollPhysics? physics,
    double? containerHeight,
    double? containerWidth,
    double viewportFraction = 1.0,
    double? itemHeight,
    double? itemWidth,
    bool outer = false,
    double scale = 1.0,
  }) {

    return Swiper(
        transformer: transformer,
        customLayoutOption: customLayoutOption,
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
        autoplay: autoplay,
        autoplayDelay: autoplayDelay,
        autoplayDisableOnInteraction: autoplayDisableOnInteraction,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        scrollDirection: scrollDirection,
        pagination: pagination,
        control: control,
        controller: controller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        key: key,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
        itemCount: children.length);
  }

  factory Swiper.list({
    required PageTransformer transformer,
    required List list,
    CustomLayoutOption? customLayoutOption,
    required SwiperDataBuilder builder,
    bool autoplay = false,
    int autoplayDelay = kDefaultAutoplayDelayMs,
    bool reverse = false,
    bool autoplayDisableOnInteraction = true,
    int duration = kDefaultAutoplayTransactionDuration,
    ValueChanged<int>? onIndexChanged,
    int index = 0,
    SwiperOnTap? onTap,
    bool loop = true,
    Curve curve = Curves.ease,
    Axis scrollDirection = Axis.horizontal,
    SwiperPlugin? pagination,
    SwiperPlugin? control,
    List<SwiperPlugin>? plugins,
    SwiperController? controller,
    Key? key,
    ScrollPhysics? physics,
    double? containerHeight,
    double? containerWidth,
    double viewportFraction = 1.0,
    double? itemHeight,
    double? itemWidth,
    bool outer = false,
    double scale = 1.0,
  }) {
    return Swiper(
        transformer: transformer,
        customLayoutOption: customLayoutOption,
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
        autoplay: autoplay,
        autoplayDelay: autoplayDelay,
        autoplayDisableOnInteraction: autoplayDisableOnInteraction,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        key: key,
        scrollDirection: scrollDirection,
        pagination: pagination,
        control: control,
        controller: controller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        itemBuilder: (BuildContext context, int index) {
          return builder(context, list[index], index);
        },
        itemCount: list.length);
  }

  @override
  State<StatefulWidget> createState() {
    return _SwiperState();
  }
}

abstract class _SwiperTimerMixin extends State<Swiper> {
  late Timer? _timer;

  late SwiperController _controller;

  @override
  void initState() {
    if (widget.controller != null) {
      _controller = widget.controller!;
    }else{
      _controller = SwiperController();
    }
    _controller.addListener(_onController);
    _handleAutoplay();
    super.initState();
  }

  void _onController() {
    switch (_controller.event) {
      case SwiperController.START_AUTOPLAY:
        {
          if (_timer == null) {
            _startAutoplay();
          }
        }
        break;
      case SwiperController.STOP_AUTOPLAY:
        {
          if (_timer != null) {
            _stopAutoplay();
          }
        }
        break;
    }
  }

  @override
  void didUpdateWidget(Swiper oldWidget) {
    if (_controller != oldWidget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller!.removeListener(_onController);
        _controller = oldWidget.controller!;
        _controller.addListener(_onController);
      }
    }
    _handleAutoplay();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.removeListener(_onController);
    _stopAutoplay();
    super.dispose();
  }

  bool _autoplayEnabled() {
    return _controller.autoplay ?? widget.autoplay;
  }

  void _handleAutoplay() {
    if (_autoplayEnabled() && _timer != null) return;
    _stopAutoplay();
    if (_autoplayEnabled()) {
      _startAutoplay();
    }
  }

  void _startAutoplay() {
    assert(_timer == null, "Timer must be stopped before start!");
    _timer =
        Timer.periodic(Duration(milliseconds: widget.autoplayDelay), _onTimer);
  }

  void _onTimer(Timer timer) {
    _controller.next(animation: true);
  }

  void _stopAutoplay() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }
}

class _SwiperState extends _SwiperTimerMixin {
  late int _activeIndex;

  late TransformerPageController? _pageController;

  Widget _wrapTap(BuildContext context, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(index);
        }
      },
      child: widget.itemBuilder(context, index),
    );
  }

  @override
  void initState() {
    _activeIndex = widget.index;
    if (_isPageViewLayout()) {
      _pageController = TransformerPageController(
          initialPage: widget.index,
          loop: widget.loop,
          itemCount: widget.itemCount ?? 0,
          reverse:
              widget.transformer == null ? false : widget.transformer!.reverse,
          viewportFraction: widget.viewportFraction);
    }
    super.initState();
  }

  bool _isPageViewLayout() {
    return widget.layout == SwiperLayout.DEFAULT;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool _getReverse(Swiper widget) =>
      widget.transformer == null ? false : widget.transformer!.reverse;

  @override
  void didUpdateWidget(Swiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isPageViewLayout()) {
      if (_pageController == null ||
          (widget.index != oldWidget.index ||
              widget.loop != oldWidget.loop ||
              widget.itemCount != oldWidget.itemCount ||
              widget.viewportFraction != oldWidget.viewportFraction ||
              _getReverse(widget) != _getReverse(oldWidget))) {
        _pageController = TransformerPageController(
            initialPage: widget.index,
            loop: widget.loop,
            itemCount: widget.itemCount ?? 0,
            reverse: _getReverse(widget),
            viewportFraction: widget.viewportFraction);
      }
    } else {
      scheduleMicrotask(() {
        // So that we have a chance to do `removeListener` in child widgets.
        if (_pageController != null) {
          _pageController!.dispose();
          _pageController = null;
        }
      });
    }
    if (widget.index != _activeIndex) {
      _activeIndex = widget.index;
    }
  }

  void _onIndexChanged(int? index) {
    if (index != null) {
      setState(() {
        _activeIndex = index;
      });
      if (widget.onIndexChanged != null) {
        widget.onIndexChanged!(index);
      }
    }
  }

  Widget _buildSwiper() {
    IndexedWidgetBuilder itemBuilder;
    if (widget.onTap != null) {
      itemBuilder = _wrapTap;
    } else {
      itemBuilder = widget.itemBuilder;
    }

    if (widget.layout == SwiperLayout.STACK) {
      return _StackSwiper(
        loop: widget.loop,
        itemWidth: widget.itemWidth ?? double.infinity,
        itemHeight: widget.itemHeight ?? double.infinity,
        itemCount: widget.itemCount ?? 0,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else if (_isPageViewLayout()) {
      PageTransformer? transformer = widget.transformer;
      if (widget.scale != null || widget.fade != null) {
        transformer =
            ScaleAndFadeTransformer(scale: widget.scale!, fade: widget.fade!);
      }

      Widget child = TransformerPageView(
        pageController: _pageController,
        loop: widget.loop,
        itemCount: widget.itemCount ?? 0,
        itemBuilder: itemBuilder,
        transformer: transformer,
        viewportFraction: widget.viewportFraction,
        index: _activeIndex,
        duration: Duration(milliseconds: widget.duration),
        scrollDirection: widget.scrollDirection,
        onPageChanged: _onIndexChanged,
        curve: widget.curve,
        physics: widget.physics,
        controller: _controller,
      );
      if (widget.autoplayDisableOnInteraction && widget.autoplay) {
        return NotificationListener(
          child: child,
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollStartNotification) {
              if (notification.dragDetails != null) {
                //by human
                if (_timer != null) _stopAutoplay();
              }
            } else if (notification is ScrollEndNotification) {
              if (_timer == null) _startAutoplay();
            }

            return false;
          },
        );
      }

      return child;
    } else if (widget.layout == SwiperLayout.TINDER) {
      return _TinderSwiper(
        loop: widget.loop,
        itemWidth: widget.itemWidth ?? double.infinity,
        itemHeight: widget.itemHeight ?? double.infinity,
        itemCount: widget.itemCount ?? 0,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else if (widget.layout == SwiperLayout.CUSTOM) {
      return _CustomLayoutSwiper(
        loop: widget.loop,
        option: widget.customLayoutOption,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount ?? 0,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else {
      return Container();
    }
  }

  SwiperPluginConfig _ensureConfig(SwiperPluginConfig? config) {
    config ??= SwiperPluginConfig(
          outer: widget.outer,
          itemCount: widget.itemCount ?? 0,
          layout: widget.layout,
          indicatorLayout: widget.indicatorLayout,
          pageController: _pageController,
          activeIndex: _activeIndex,
          scrollDirection: widget.scrollDirection,
          controller: _controller,
          loop: widget.loop);
    return config;
  }

  List<Widget> _ensureListForStack(
      Widget swiper, List<Widget>? listForStack, Widget widget) {
    if (listForStack == null) {
      listForStack = [swiper, widget];
    } else {
      listForStack.add(widget);
    }
    return listForStack;
  }

  @override
  Widget build(BuildContext context) {
    Widget swiper = _buildSwiper();
    List<Widget>? listForStack;
    SwiperPluginConfig? config;
    if (widget.control != null) {
      //Stack
      config = _ensureConfig(config);
      listForStack = _ensureListForStack(
          swiper, listForStack, widget.control!.build(context, config));
    }

    if (widget.plugins != null) {
      config = _ensureConfig(config);
      for (SwiperPlugin plugin in widget.plugins!) {
        listForStack = _ensureListForStack(
            swiper, listForStack, plugin.build(context, config));
      }
    }
    if (widget.pagination != null) {
      config = _ensureConfig(config);
      if (widget.outer) {
        return _buildOuterPagination(
            widget.pagination as SwiperPagination,
            listForStack == null ? swiper : Stack(children: listForStack),
            config);
      } else {
        listForStack = _ensureListForStack(
            swiper, listForStack, widget.pagination!.build(context, config));
      }
    }

    if (listForStack != null) {
      return Stack(
        children: listForStack,
      );
    }

    return swiper;
  }

  Widget _buildOuterPagination(
      SwiperPagination pagination, Widget swiper, SwiperPluginConfig config) {
    List<Widget> list = [];
    //Only support bottom yet!
    if (widget.containerHeight != null || widget.containerWidth != null) {
      list.add(swiper);
    } else {
      list.add(Expanded(child: swiper));
    }

    list.add(Align(
      alignment: Alignment.center,
      child: pagination.build(context, config),
    ));

    return Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
    );
  }
}

abstract class _SubSwiper extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final int? index;
  final ValueChanged<int>? onIndexChanged;
  final SwiperController controller;
  final int duration;
  final Curve curve;
  final double? itemWidth;
  final double? itemHeight;
  final bool loop;
  final Axis scrollDirection;

  const _SubSwiper(
      {
        Key? key,
        this.loop = true,
        this.itemHeight,
        this.itemWidth,
        this.duration = kDefaultAutoplayTransactionDuration,
        this.curve = Curves.ease,
        required this.itemBuilder,
        required this.controller,
        this.index,
        required this.itemCount,
        this.scrollDirection = Axis.horizontal,
        this.onIndexChanged
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState();

  int getCorrectIndex(int indexNeedsFix) {
    if (itemCount == 0) return 0;
    int value = indexNeedsFix % itemCount;
    if (value < 0) {
      value += itemCount;
    }
    return value;
  }
}

class _TinderSwiper extends _SubSwiper {
  const _TinderSwiper({
    Key? key,
    Curve curve = Curves.ease,
    int duration = kDefaultAutoplayTransactionDuration,
    required SwiperController controller,
    ValueChanged<int>? onIndexChanged,
    required double itemHeight,
    required double itemWidth,
    required IndexedWidgetBuilder itemBuilder,
    int? index,
    bool loop = true,
    required int itemCount,
    Axis scrollDirection = Axis.horizontal,
  })  : super(
            loop: loop,
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount,
            scrollDirection: scrollDirection);

  @override
  State<StatefulWidget> createState() {
    return _TinderState();
  }
}

class _StackSwiper extends _SubSwiper {
  const _StackSwiper({
    Key? key,
    Curve curve = Curves.ease,
    int duration = kDefaultAutoplayTransactionDuration,
    required SwiperController controller,
    ValueChanged<int>? onIndexChanged,
    double? itemHeight,
    double? itemWidth,
    required IndexedWidgetBuilder itemBuilder,
    int? index,
    bool loop = true,
    required int itemCount,
    Axis scrollDirection = Axis.horizontal,
  }) : super(
            loop: loop,
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount,
            scrollDirection: scrollDirection);

  @override
  State<StatefulWidget> createState() {
    return _StackViewState();
  }
}

class _TinderState extends _CustomLayoutStateBase<_TinderSwiper> {
  late List<double> scales;
  late List<double> offsetsX;
  late List<double> offsetsY;
  late List<double> opacity;
  late List<double> rotates;

  double getOffsetY(double scale) {
    return widget.itemHeight ?? double.infinity - (widget.itemHeight ?? double.infinity) * scale;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(_TinderSwiper oldWidget) {
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterRender() {
    super.afterRender();

    _startIndex = -3;
    _animationCount = 5;
    opacity = [0.0, 0.9, 0.9, 1.0, 0.0, 0.0];
    scales = [0.80, 0.80, 0.85, 0.90, 1.0, 1.0, 1.0];
    rotates = [0.0, 0.0, 0.0, 0.0, 20.0, 25.0];
    _updateValues();
  }

  void _updateValues() {
    if (widget.scrollDirection == Axis.horizontal) {
      offsetsX = [0.0, 0.0, 0.0, 0.0, _swiperWidth, _swiperWidth];
      offsetsY = [
        0.0,
        0.0,
        -5.0,
        -10.0,
        -15.0,
        -20.0,
      ];
    } else {
      offsetsX = [
        0.0,
        0.0,
        5.0,
        10.0,
        15.0,
        20.0,
      ];

      offsetsY = [0.0, 0.0, 0.0, 0.0, _swiperHeight, _swiperHeight];
    }
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    double s = _getValue(scales, animationValue, i);
    double f = _getValue(offsetsX, animationValue, i);
    double fy = _getValue(offsetsY, animationValue, i);
    double o = _getValue(opacity, animationValue, i);
    double a = _getValue(rotates, animationValue, i);

    Alignment alignment = widget.scrollDirection == Axis.horizontal
        ? Alignment.bottomCenter
        : Alignment.centerLeft;

    return Opacity(
      opacity: o,
      child: Transform.rotate(
        angle: a / 180.0,
        child: Transform.translate(
          key: ValueKey<int>(_currentIndex + i),
          offset: Offset(f, fy),
          child: Transform.scale(
            scale: s,
            alignment: alignment,
            child: SizedBox(
              width: widget.itemWidth ?? double.infinity,
              height: widget.itemHeight ?? double.infinity,
              child: widget.itemBuilder(context, realIndex),
            ),
          ),
        ),
      ),
    );
  }
}

class _StackViewState extends _CustomLayoutStateBase<_StackSwiper> {
  late List<double> scales;
  late List<double> offsets;
  late List<double> opacity;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _updateValues() {
    if (widget.scrollDirection == Axis.horizontal) {
      double space = (_swiperWidth - (widget.itemWidth ?? double.infinity)) / 2;
      offsets = [-space, -space / 3 * 2, -space / 3, 0.0, _swiperWidth];
    } else {
      double space = (_swiperHeight - (widget.itemHeight ?? double.infinity)) / 2;
      offsets = [-space, -space / 3 * 2, -space / 3, 0.0, _swiperHeight];
    }
  }

  @override
  void didUpdateWidget(_StackSwiper oldWidget) {
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterRender() {
    super.afterRender();

    //length of the values array below
    _animationCount = 5;

    //Array below this line, '0' index is 1.0 ,witch is the first item show in swiper.
    _startIndex = -3;
    scales = [0.7, 0.8, 0.9, 1.0, 1.0];
    opacity = [0.0, 0.5, 1.0, 1.0, 1.0];

    _updateValues();
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    double s = _getValue(scales, animationValue, i);
    double f = _getValue(offsets, animationValue, i);
    double o = _getValue(opacity, animationValue, i);

    Offset offset = widget.scrollDirection == Axis.horizontal
        ? Offset(f, 0.0)
        : Offset(0.0, f);

    Alignment alignment = widget.scrollDirection == Axis.horizontal
        ? Alignment.centerLeft
        : Alignment.topCenter;

    return Opacity(
      opacity: o,
      child: Transform.translate(
        key: ValueKey<int>(_currentIndex + i),
        offset: offset,
        child: Transform.scale(
          scale: s,
          alignment: alignment,
          child: SizedBox(
            width: widget.itemWidth ?? double.infinity,
            height: widget.itemHeight ?? double.infinity,
            child: widget.itemBuilder(context, realIndex),
          ),
        ),
      ),
    );
  }
}

class ScaleAndFadeTransformer extends PageTransformer {
  final double _scale;
  final double _fade;

  ScaleAndFadeTransformer({double fade = 0.3, double scale = 0.8})
      : _fade = fade,
        _scale = scale;

  @override
  Widget transform(Widget item, TransformInfo info) {
    double position = info.position ?? 0.0;
    Widget child = item;
    double scaleFactor = (1 - position.abs()) * (1 - _scale);
    double scale = _scale + scaleFactor;

    child = Transform.scale(
      scale: scale,
      child: item,
    );

    double fadeFactor = (1 - position.abs()) * (1 - _fade);
    double opacity = _fade + fadeFactor;
    child = Opacity(
      opacity: opacity,
      child: child,
    );

    return child;
  }
}
