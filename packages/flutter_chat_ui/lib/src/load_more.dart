import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/load_more_notifier.dart';

/// A widget displayed at the top of the chat list when paginating
/// (loading more historical messages).
///
/// Typically shows a [CircularProgressIndicator].
class LoadMore extends StatefulWidget {
  /// Color of the progress indicator. Defaults to theme's `onSurface`.
  final Color? color;

  /// Vertical padding around the indicator.
  final double? padding;

  /// Size (diameter) of the progress indicator.
  final double? size;

  /// Creates a load more indicator widget.
  const LoadMore({super.key, this.color, this.padding = 20, this.size = 20});

  @override
  State<LoadMore> createState() => _LoadMoreState();
}

class _LoadMoreState extends State<LoadMore> {
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ChatTheme t) => (onSurface: t.colors.onSurface),
    );

    return Padding(
      key: _key,
      padding: EdgeInsets.symmetric(vertical: widget.padding ?? 0),
      child: Center(
        child: SizedBox(
          height: widget.size,
          width: widget.size,
          child: CircularProgressIndicator(
            color: widget.color ?? theme.onSurface,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    );
  }

  void _measure() {
    if (!mounted) return;

    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final height = renderBox.size.height;
      context.read<LoadMoreNotifier>().setHeight(height);
    }
  }
}
