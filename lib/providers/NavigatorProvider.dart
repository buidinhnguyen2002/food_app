import 'package:flutter/material.dart';

class NavigatorProvider with ChangeNotifier {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey {
    return _navigatorKey;
  }
}
