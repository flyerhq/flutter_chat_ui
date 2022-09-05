/// Used to set [Input] clear mode when message is sent.
enum InputClearMode {
  /// Always clear [Input] regardless if message is sent or not.
  always,

  /// Never clear [Input]. You should do it manually, depending on your use case.
  /// To clear the input manually, use [Input.options.textEditingController] (see
  /// docs how to use it properly, but TL;DR set it to [InputTextFieldController]
  /// imported from the library, to not lose any functionalily).
  never,
}
