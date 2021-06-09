package com.idlefish.flutterboost;

import java.util.HashMap;

public interface FlutterBoostDelegate {
    void pushNativeRoute(String pageName, HashMap<String, Object> arguments);
    void pushFlutterRoute(String pageName, String uniqueId, HashMap<String, Object> arguments);
}
