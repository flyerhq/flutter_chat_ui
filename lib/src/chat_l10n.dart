import 'package:flutter/material.dart';

/// Base chat l10n containing all required properties to provide localized copy.
/// Extend this class if you want to create a custom l10n.
@immutable
abstract class ChatL10n {
  /// Creates a new chat l10n based on provided copy
  const ChatL10n({
    required this.attachmentButtonAccessibilityLabel,
    required this.emptyChatPlaceholder,
    required this.fileButtonAccessibilityLabel,
    required this.inputPlaceholder,
    required this.sendButtonAccessibilityLabel,
  });

  /// Accessibility label (hint) for the attachment button
  final String attachmentButtonAccessibilityLabel;

  /// Placeholder when there are no messages
  final String emptyChatPlaceholder;

  /// Accessibility label (hint) for the tap action on file message
  final String fileButtonAccessibilityLabel;

  /// Placeholder for the text field
  final String inputPlaceholder;

  /// Accessibility label (hint) for the send button
  final String sendButtonAccessibilityLabel;
}

/// English l10n which extends [ChatL10n]
@immutable
class ChatL10nEn extends ChatL10n {
  /// Creates English l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nEn({
    String attachmentButtonAccessibilityLabel = 'Send media',
    String emptyChatPlaceholder = 'No messages here yet',
    String fileButtonAccessibilityLabel = 'File',
    String inputPlaceholder = 'Message',
    String sendButtonAccessibilityLabel = 'Send',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}

/// Spanish l10n which extends [ChatL10n]
@immutable
class ChatL10nEs extends ChatL10n {
  /// Creates Spanish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nEs({
    String attachmentButtonAccessibilityLabel = 'Enviar multimedia',
    String emptyChatPlaceholder = 'Aún no hay mensajes',
    String fileButtonAccessibilityLabel = 'Archivo',
    String inputPlaceholder = 'Mensaje',
    String sendButtonAccessibilityLabel = 'Enviar',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}

/// Korean l10n which extends [ChatL10n]
@immutable
class ChatL10nKo extends ChatL10n {
  /// Creates Korean l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nKo({
    String attachmentButtonAccessibilityLabel = '미디어 보내기',
    String emptyChatPlaceholder = '주고받은 메시지가 없습니다',
    String fileButtonAccessibilityLabel = '파일',
    String inputPlaceholder = '메시지',
    String sendButtonAccessibilityLabel = '보내기',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}

/// Polish l10n which extends [ChatL10n]
@immutable
class ChatL10nPl extends ChatL10n {
  /// Creates Polish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nPl({
    String attachmentButtonAccessibilityLabel = 'Wyślij multimedia',
    String emptyChatPlaceholder = 'Tu jeszcze nie ma wiadomości',
    String fileButtonAccessibilityLabel = 'Plik',
    String inputPlaceholder = 'Napisz wiadomość',
    String sendButtonAccessibilityLabel = 'Wyślij',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}

/// Portuguese l10n which extends [ChatL10n]
@immutable
class ChatL10nPt extends ChatL10n {
  /// Creates Portuguese l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nPt({
    String attachmentButtonAccessibilityLabel = 'Envia mídia',
    String emptyChatPlaceholder = 'Ainda não há mensagens aqui',
    String fileButtonAccessibilityLabel = 'Arquivo',
    String inputPlaceholder = 'Mensagem',
    String sendButtonAccessibilityLabel = 'Enviar',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}

/// Russian l10n which extends [ChatL10n]
@immutable
class ChatL10nRu extends ChatL10n {
  /// Creates Russian l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nRu({
    String attachmentButtonAccessibilityLabel = 'Отправить медиа',
    String emptyChatPlaceholder = 'Пока что у вас нет сообщений',
    String fileButtonAccessibilityLabel = 'Файл',
    String inputPlaceholder = 'Сообщение',
    String sendButtonAccessibilityLabel = 'Отправить',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}

/// Turkish l10n which extends [ChatL10n]
@immutable
class ChatL10nTr extends ChatL10n {
  /// Creates Turkish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nTr({
    String attachmentButtonAccessibilityLabel = 'Medya gönder',
    String emptyChatPlaceholder = 'Henüz mesaj yok',
    String fileButtonAccessibilityLabel = 'Dosya',
    String inputPlaceholder = 'Mesaj yazın',
    String sendButtonAccessibilityLabel = 'Gönder',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}

/// Ukrainian l10n which extends [ChatL10n]
@immutable
class ChatL10nUk extends ChatL10n {
  /// Creates Ukrainian l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nUk({
    String attachmentButtonAccessibilityLabel = 'Надіслати медіа',
    String emptyChatPlaceholder = 'Повідомлень ще немає',
    String fileButtonAccessibilityLabel = 'Файл',
    String inputPlaceholder = 'Повідомлення',
    String sendButtonAccessibilityLabel = 'Надіслати',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}

/// Simplified Chinese l10n which extends [ChatL10n]
@immutable
class ChatL10nZhCN extends ChatL10n {
  /// Creates Simplified Chinese l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nZhCN({
    String attachmentButtonAccessibilityLabel = '发送媒体文件',
    String emptyChatPlaceholder = '暂无消息',
    String fileButtonAccessibilityLabel = '文件',
    String inputPlaceholder = '输入消息',
    String sendButtonAccessibilityLabel = '发送',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}
