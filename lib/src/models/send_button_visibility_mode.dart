/// Used to toggle the visibility behavior of the [SendButton] based on the
/// [TextField] state inside the [Input] widget.
enum SendButtonVisibilityMode {
  /// Always show the [SendButton] regardless of the [TextField] state.
  always,

  /// The [SendButton] will only appear when the [TextField] is not empty.
  editing,
}
