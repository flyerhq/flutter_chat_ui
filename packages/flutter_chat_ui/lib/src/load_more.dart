import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/load_more_notifier.dart';

class LoadMore extends StatefulWidget {
  final Color? color;
  final double? padding;
  final double? size;

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
    final color = context.select((ChatTheme theme) => theme.colors.onSurface);

    return Padding(
      key: _key,
      padding: EdgeInsets.symmetric(vertical: widget.padding ?? 0),
      child: Center(
        child: SizedBox(
          height: widget.size,
          width: widget.size,
          child: CircularProgressIndicator(
            color: widget.color ?? color,
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
