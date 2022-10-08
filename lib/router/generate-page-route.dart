import 'package:flutter/cupertino.dart';

class GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String? routeName;
  GeneratePageRoute({required this.widget, required this.routeName})
      : super(
    settings: RouteSettings(name: routeName),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      // return SlideTransition(
      //   position: animation.drive(tween),
      //   child: child,
      // );
      return SlideTransition(
        textDirection: TextDirection.rtl,
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}