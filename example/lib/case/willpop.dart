import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class WillPopRoute extends StatefulWidget {
  WillPopRoute(BuildContext context, {Key? key, required this.title}) : navigatorContext = context, super(key: key);
  BuildContext navigatorContext;
  final String title;

  @override
  State<StatefulWidget> createState() => new _WillPopRouteState();
}

class _WillPopRouteState extends State<WillPopRoute> {
  Future<bool> _onWillPop() {
    final completer = Completer<bool>();
    final BuildContext navigatorContext = widget.navigatorContext;
    final Future<bool?> result = showDialog<bool>(
          context: context,
          builder: (navigatorContext) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(navigatorContext).pop(false);
                },
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(navigatorContext).pop(true);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        );

    result.then((value) => completer.complete(value));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("WillPopRoute"),
        ),
        body: new Center(
          child: new Text("返回的时候提示弹窗"),
        ),
      ),
    );
  }
}
