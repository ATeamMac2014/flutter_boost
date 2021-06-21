import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_boost/boost_navigator.dart';
import 'package:flutter_boost/flutter_boost_app.dart';
import 'overlay_entry.dart';
import 'package:flutter/scheduler.dart';

class BoostContainer extends StatefulWidget {
  BoostContainer(
      {LocalKey? key, required this.routeFactory, required this.pageInfo})
      : super(key: key) {
    pages.add(BoostPage.create(pageInfo, routeFactory));
  }

  ContainerOverlayEntry? _owner;

  static BoostContainer? of(BuildContext context) {
    final BoostContainer? container =
        context.findAncestorWidgetOfExactType<BoostContainer>();
    return container;
  }

  final FlutterBoostRouteFactory routeFactory;
  final PageInfo pageInfo;
  final List<BoostPage<dynamic>> _pages = <BoostPage<dynamic>>[];

  List<BoostPage<dynamic>> get pages => _pages;
  BoostPage<dynamic> get topPage => pages.last;

  int get size => pages.length;

  NavigatorState? get navigator => _navKey.currentState;
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  void detach() {
    if (_owner != null) {
      _owner?.remove();
    }

    _owner = null;

    // Ensure this frame is refreshed after schedule frame，otherwise the PageState.dispose may not be called
    final instance = SchedulerBinding.instance;
    if (instance != null) {
      final bool hasScheduledFrame = instance.hasScheduledFrame;
      final bool framesEnabled = instance.framesEnabled;

      if (hasScheduledFrame || !framesEnabled) {
        instance.scheduleWarmUpFrame();
      }
    }
  }

  void attach(ContainerOverlayEntry entry) {
    assert(_owner == null);
    _owner = entry;
  }

  @override
  State<StatefulWidget> createState() => BoostContainerState();

  void push(BoostPage<dynamic> page) {
    _pages.add(page);
    final router = page.createRoute(_navKey.currentContext!);
    navigator?.push<dynamic>(router);
  }

  void pop() {
    navigator?.pop();
  }

  void popUntil(String pageName) {
    navigator?.popUntil((route) {
      return route.settings.name == pageName;
    });
  }
}

class BoostContainerState extends State<BoostContainer> {
  void _updatePagesList() {
    widget.pages.removeLast();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget._navKey,
      pages: List<Page<dynamic>>.of(widget._pages),
      onPopPage: (Route<dynamic> route, dynamic result) {
        if (route.didPop(result)) {
          _updatePagesList();
          return true;
        }
        return false;
      },
      observers: <NavigatorObserver>[
        BoostNavigatorObserver(widget._pages, widget.pageInfo.uniqueId),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
