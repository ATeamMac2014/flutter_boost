import 'package:flutter/widgets.dart';
import 'package:flutter_boost/flutter_boost_app.dart';
import 'package:flutter_boost/messages.dart';
import 'package:flutter_boost/overlay_entry.dart';

import 'boost_container.dart';

/// A object that manages a set of pages with a hybrid stack.
///
class BoostNavigator {
  const BoostNavigator(this.appState);

  final FlutterBoostAppState appState;

  /// Retrieves the instance of [BoostNavigator]
  static BoostNavigator of() {
    BuildContext? context = overlayKey.currentContext;
    if (context != null) {
      FlutterBoostAppState? appState;
      appState = context.findAncestorStateOfType<FlutterBoostAppState>();
      if (appState != null) {
        return BoostNavigator(appState);
      } else {
        throw Exception('appState is null');
      }
    } else {
      throw Exception('overlayKey.currentContext is null');
    }
  }

  /// Whether this page with the given [name] is a flutter page
  ///
  /// If the name of route can be found in route table then return true,
  /// otherwise return false.
  bool isFlutterPage(String name) {
    return appState.routeFactory(RouteSettings(name: name), "") != null;
  }

  /// Push the page with the given [name] onto the hybrid stack.
  Future<T?> push<T extends Object>(String name,
      {Map<Object, Object>? arguments, bool withContainer = true}) {
    if (isFlutterPage(name)) {
      return appState.pushWithResult(name,
          arguments: arguments, withContainer: withContainer);
    } else {
      final CommonParams params = CommonParams()
        ..pageName = name
        ..arguments = arguments;
      appState.nativeRouterApi.pushNativeRoute(params);
      return Future<T?>(() => null);
    }
  }

  void enablePanGesture(String uniqueId, bool enable) {
    return appState.enablePanGesture(uniqueId, enable);
  }

  /// Pop the top-most page off the hybrid stack.
  Future<void> pop<T extends Object>([T? result]) async {
    return appState.popWithResult(result);
  }

  Future<void> popUtil<T extends Object>(String uniqueId, [T? result]) async {
    await appState.popUntil(uniqueId);
  }

  /// Remove the page with the given [uniqueId] from hybrid stack.
  ///
  /// This API is for backwards compatibility.
  void remove(String uniqueId) {
    appState.pop(uniqueId: uniqueId);
  }

  /// Retrieves the infomation of the top-most flutter page
  /// on the hybrid stack, such as uniqueId, pagename, etc;
  ///
  /// This is a legacy API for backwards compatibility.
  PageInfo getTopPageInfo() {
    return appState.getTopPageInfo();
  }

  PageInfo? getTopByContext(BuildContext context) {
    return BoostContainer.of(context)?.pageInfo;
  }

  /// Return the number of flutter pages
  ///
  /// This is a legacy API for backwards compatibility.
  int pageSize() {
    return appState.pageSize();
  }
}

class PageInfo {
  PageInfo(
      {required this.pageName,
      required this.uniqueId,
      this.arguments,
      this.withContainer = true});

  bool withContainer;
  String pageName;
  String uniqueId;
  Map<dynamic, dynamic>? arguments;
}
