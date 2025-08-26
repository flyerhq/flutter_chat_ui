import 'package:flutter/material.dart';

class HeroVideoRoute<T> extends PageRoute<T> {
  // The constructor takes a WidgetBuilder and an optional fullscreenDialog flag.
  // The WidgetBuilder is assigned to _builder and the fullscreenDialog flag is passed to the superclass constructor.
  HeroVideoRoute({required WidgetBuilder builder, super.fullscreenDialog})
    : _builder = builder;

  final WidgetBuilder _builder;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => false;

  // The color of the barrier (the area outside the content)
  @override
  Color get barrierColor => Colors.transparent;

  // This method builds the transition animation for the route.
  // In this case, it simply returns the child widget as is, without any transition.
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }

  // This method builds the page to be displayed by the route.
  // It uses the _builder provided in the constructor to build the page.
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _builder(context);
  }

  // This is the semantic label for the barrier. It is used by screen reading software for visually impaired users.
  @override
  String get barrierLabel => 'Video player open';
}
