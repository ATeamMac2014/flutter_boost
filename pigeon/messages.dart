import 'package:pigeon/pigeon.dart';

class CommonParams {
  String? pageName;
  String? uniqueId;
  Map<String, String>? arguments;
}

class PanGestureParams {
  String uniqueId;
  bool enable;

  PanGestureParams(this.uniqueId, this.enable);
}

@HostApi()
abstract class NativeRouterApi {
  void pushNativeRoute(CommonParams param);
  void pushFlutterRoute(CommonParams param);
  void popRoute(CommonParams param);
  void enablePanGesture(PanGestureParams params);
}

@FlutterApi()
abstract class FlutterRouterApi {
  void pushRoute(CommonParams param);
  void popRoute(CommonParams param);
  void removeRoute(CommonParams param);
  void onForeground(CommonParams param);
  void onBackground(CommonParams param);
  void onNativeViewShow(CommonParams param);
  void onNativeViewHide(CommonParams param);
}

void configurePigeon(PigeonOptions opts) {
  opts.dartOut = 'lib/messages.dart';
  opts.objcHeaderOut = 'ios/Classes/messages.h';
  opts.objcSourceOut = 'ios/Classes/messages.m';
  opts.objcOptions?.prefix = 'FB';
  opts.javaOut =
      'android/src/main/java/com/idlefish/flutterboost/Messages.java';
}
