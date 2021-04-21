import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost_app.dart';
import 'package:flutter_boost_example/case/flutter_to_flutter_sample.dart';
import 'package:flutter_boost_example/case/image_pick.dart';
import 'package:flutter_boost_example/case/media_query.dart';
import 'package:flutter_boost_example/case/return_data.dart';
import 'package:flutter_boost_example/case/willpop.dart';
import 'package:flutter_boost_example/flutter_page.dart';
import 'package:flutter_boost_example/simple_page_widgets.dart';
import 'package:flutter_boost_example/tab/simple_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static Map<String, PageBuilder> routerMap = {
    '/': (context, settings) {
      return Container();
    },
    'embedded': (context, settings) {
      return  EmbeddedFirstRouteWidget();
    },
    'presentFlutterPage': (context, settings) {
      return  FlutterRouteWidget(
                params: settings.arguments as Map<dynamic, dynamic> ,
                uniqueId: "",
              );
    },
    'imagepick': (context, settings) {
      return  ImagePickerPage(title: "xxx", uniqueId: "");
    },
    'firstFirst': (context, settings) {
      return FirstFirstRouteWidget();
    },
    'willPop': (context, settings) {
      return WillPopRoute(context, title: 'popRoute');
    },
    'returnData': (context, settings) {
      return  ReturnDataWidget();
    },
    'secondStateful': (context, settings) {
      return SecondStatefulRouteWidget();
    },
    'platformView': (context, settings) {
      return PlatformRouteWidget();
    },

    ///可以在native层通过 getContainerParams 来传递参数
    'flutterPage': (context, settings) {
      return FlutterRouteWidget(
          params: settings.arguments as Map<dynamic, dynamic>,
          uniqueId: "");
    },
    'tab_friend': (context, settings) {
      return  SimpleWidget(
              "", settings.arguments as Map<dynamic, dynamic>, "This is a flutter fragment");
    },
    'tab_message': (context, settings) {
      return SimpleWidget(
              "", settings.arguments as Map<dynamic, dynamic>, "This is a flutter fragment");
    },
    'tab_flutter1': (context, settings) {
      return SimpleWidget(
              "", settings.arguments as Map<dynamic, dynamic>, "This is a custom FlutterView");
    },
    'tab_flutter2': (context, settings) {
      return SimpleWidget(
              "", settings.arguments as Map<dynamic, dynamic>, "This is a custom FlutterView");
    },

    'f2f_first': (context, settings) {
      return F2FFirstPage();
    },
    'f2f_second': (context, settings) {
      return F2FSecondPage();
    },
    'mediaquery': (context, settings) {
      return MediaQueryRouteWidget(
                params: settings.arguments as Map<dynamic, dynamic>,
                message: '',
                uniqueId: "",
              );
    },
  };

  Route<dynamic> routeFactory(RouteSettings settings, String uniqueId) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      pageBuilder: (context, __, ___) {
        final PageBuilder? func = routerMap[settings.name];
        if (func != null) {
          return func(context, settings);
        } else {
          // 404
          return Container();
        }
      }
      // ,
      // transitionsBuilder: (BuildContext context, Animation<double> animation,
      //     Animation<double> secondaryAnimation, Widget child) {
      //   return SlideTransition(
      //     position: Tween<Offset>(
      //       begin: const Offset(1.0, 0),
      //       end: Offset.zero,
      //     ).animate(animation),
      //     child: SlideTransition(
      //       position: Tween<Offset>(
      //         begin: Offset.zero,
      //         end: const Offset(-1.0, 0),
      //       ).animate(secondaryAnimation),
      //       child: child,
      //     ),
      //   );
      // },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(routeFactory);
  }

  static Widget appBuilder(Widget home) {
    return MaterialApp(
      home: home,
    );
  }

  void _onRoutePushed(
      String pageName, String uniqueId, Map params, Route route, Future _) {}
}

class BoostNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('boost-didPush' + route.settings.name!);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('boost-didPop' + route.settings.name!);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('boost-didRemove' + route.settings.name!);
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('boost-didStartUserGesture' + route.settings.name!);
  }
}
