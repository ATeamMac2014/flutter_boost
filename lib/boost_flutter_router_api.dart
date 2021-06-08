import 'package:flutter_boost/flutter_boost_app.dart';
import 'package:flutter_boost/messages.dart';

/// The MessageChannel counterpart on the Dart side.
class BoostFlutterRouterApi extends FlutterRouterApi {
  
  factory BoostFlutterRouterApi(FlutterBoostAppState appState) {
    BoostFlutterRouterApi? instance = _instance;
    if (instance == null) {
      instance = BoostFlutterRouterApi._(appState);
      _instance = instance;
      FlutterRouterApi.setup(instance);
    }
    return instance;
  }

  BoostFlutterRouterApi._(this.appState);

  final FlutterBoostAppState appState;
  static BoostFlutterRouterApi? _instance = null;

  @override
  void pushRoute(CommonParams arg) {
    final pageName = arg.pageName;
    final uniqueId = arg.uniqueId;
    if (pageName != null && uniqueId != null) {
      appState.push(pageName,
          uniqueId: uniqueId, arguments: arg.arguments, withContainer: true);
    }
  }

  @override
  void popRoute(CommonParams arg) {
    appState.pop(uniqueId: arg.uniqueId);
  }

  @override
  void onForeground(CommonParams arg) {
    appState.onForeground();
  }

  @override
  void onBackground(CommonParams arg) {
    appState.onBackground();
  }

  @override
  void onNativeViewShow(CommonParams arg) {
    appState.onNativeViewShow();
  }

  @override
  void onNativeViewHide(CommonParams arg) {
    appState.onNativeViewHide();
  }

  @override
  void removeRoute(CommonParams arg) {
    appState.removeRouter(arg.uniqueId);
  }
}
