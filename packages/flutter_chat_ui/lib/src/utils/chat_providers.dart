import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../chat.dart';
import 'composer_height_notifier.dart';
import 'load_more_notifier.dart';
import 'typedefs.dart';

/// A utility class to re-expose the current Chat-related providers
/// for use in dialogs, custom routes, or overlays.
///
/// This ensures that context-dependent widgets (e.g., using `context.watch`)
/// work properly in a new widget tree.
///
///
/// IMPORTANT: Keep this list in sync with the main MultiProvider in [Chat]].

class ChatProviders {
  /// Recreates the list of `Provider`s from the current [context],
  /// so you can rewrap a new widget subtree (e.g. in a Hero route or dialog).
  static List<SingleChildWidget> from(BuildContext context) => [
    Provider.value(value: mustRead<UserID>(context)),
    Provider.value(value: mustRead<ResolveUserCallback>(context)),
    Provider.value(value: mustRead<ChatController>(context)),
    Provider.value(value: mustRead<ChatTheme>(context)),
    Provider.value(value: mustRead<Builders>(context)),
    Provider.value(value: mustRead<CrossCache>(context)),
    ChangeNotifierProvider.value(value: mustRead<UserCache>(context)),
    Provider.value(value: mustRead<DateFormat>(context)),

    // Optional callbacks use context.read<T?>() directly:
    Provider.value(value: context.read<OnMessageSendCallback?>()),
    Provider.value(value: context.read<OnMessageTapCallback?>()),
    Provider.value(value: context.read<OnMessageReactionCallback?>()),
    Provider.value(value: context.read<OnMessageLongPressCallback?>()),
    Provider.value(value: context.read<OnAttachmentTapCallback?>()),

    ChangeNotifierProvider.value(
      value: mustRead<ComposerHeightNotifier>(context),
    ),
    ChangeNotifierProvider.value(value: mustRead<LoadMoreNotifier>(context)),
  ];
}

/// Safely reads a provider from the given [context].
/// Throws a clear error if the provider is missing,
/// instead of silently crashing at runtime.
T mustRead<T>(BuildContext context) {
  try {
    return context.read<T>();
  } catch (e, stack) {
    throw FlutterError.fromParts([
      ErrorSummary('Missing provider for type $T'),
      ErrorDescription(
        'ChatProviders.from(context) tried to read a $T, but it was not found in the widget tree.',
      ),
      ErrorHint('Ensure this provider is available in the current context.'),
      DiagnosticsStackTrace('Stack trace', stack),
    ]);
  }
}
