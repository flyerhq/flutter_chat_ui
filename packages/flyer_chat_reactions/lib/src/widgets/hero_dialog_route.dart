import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  // The constructor takes a WidgetBuilder and an optional fullscreenDialog flag.
  // The WidgetBuilder is assigned to _builder and the fullscreenDialog flag is passed to the superclass constructor.
  HeroDialogRoute({
    required WidgetBuilder builder,
    super.fullscreenDialog,
  })  : _builder = builder;

  // This is the builder for creating the widget that will be displayed by the route.
  final WidgetBuilder _builder;

  // This route is not opaque, meaning that it does not obscure the entire screen.
  @override
  bool get opaque => false;

  // This route can be dismissed by tapping outside the dialog area.
  @override
  bool get barrierDismissible => true;

  // The transition for this route lasts 300 milliseconds.
  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  // This route maintains its state when it is not visible.
  @override
  bool get maintainState => true;

  // The color of the barrier (the area outside the dialog) is semi-transparent black.
  @override
  Color get barrierColor => Colors.black54;

  // This method builds the transition animation for the route.
  // In this case, it simply returns the child widget as is, without any transition.
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  // This method builds the page to be displayed by the route.
  // It uses the _builder provided in the constructor to build the page.
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  // This is the semantic label for the barrier. It is used by screen reading software for visually impaired users.
  @override
  String get barrierLabel => 'Popup dialog open';

}