import 'package:flutter/material.dart';

/// Base chat l10n containing all required variables to provide localized copy.
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
    required this.today,
    required this.yesterday,
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

  /// Today string
  final String today;

  /// Yesterday string
  final String yesterday;
}

/// English l10n which extends [ChatL10n]
@immutable
class ChatL10nEn extends ChatL10n {
  /// Creates English l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nEn({
    String attachmentButtonAccessibilityLabel = 'Send media',
    String emptyChatPlaceholder = 'No messages here yet',
    String fileButtonAccessibilityLabel = 'File',
    String inputPlaceholder = 'Message',
    String sendButtonAccessibilityLabel = 'Send',
    String today = 'Today',
    String yesterday = 'Yesterday',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
        );
}

/// Portuguese l10n which extends [ChatL10n]
@immutable
class ChatL10nPt extends ChatL10n {
  /// Creates Portuguese l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nPt({
    String attachmentButtonAccessibilityLabel = 'Enviar mídia',
    String emptyChatPlaceholder = 'Não há mensagens ainda',
    String fileButtonAccessibilityLabel = 'Arquivo',
    String inputPlaceholder = 'Mensagem',
    String sendButtonAccessibilityLabel = 'Enviar',
    String today = 'Hoje',
    String yesterday = 'Ontem',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
        );
}

/// Spanish l10n which extends [ChatL10n]
@immutable
class ChatL10nEs extends ChatL10n {
  /// Creates Spanish l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nEs({
    String attachmentButtonAccessibilityLabel = 'Enviar multimedia',
    String emptyChatPlaceholder = 'Aún no hay mensajes',
    String fileButtonAccessibilityLabel = 'Archivo',
    String inputPlaceholder = 'Mensaje',
    String sendButtonAccessibilityLabel = 'Enviar',
    String today = 'Hoy',
    String yesterday = 'Ayer',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
        );
}

/// Polish l10n which extends [ChatL10n]
@immutable
class ChatL10nPl extends ChatL10n {
  /// Creates Polish l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nPl({
    String attachmentButtonAccessibilityLabel = 'Wyślij multimedia',
    String emptyChatPlaceholder = 'Tu jeszcze nie ma wiadomości',
    String fileButtonAccessibilityLabel = 'Plik',
    String inputPlaceholder = 'Napisz wiadomość',
    String sendButtonAccessibilityLabel = 'Wyślij',
    String today = 'Dzisiaj',
    String yesterday = 'Wczoraj',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
        );
}

/// Russian l10n which extends [ChatL10n]
@immutable
class ChatL10nRu extends ChatL10n {
  /// Creates Russian l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nRu({
    String attachmentButtonAccessibilityLabel = 'Отправить медиа',
    String emptyChatPlaceholder = 'Пока что у вас нет сообщений',
    String fileButtonAccessibilityLabel = 'Файл',
    String inputPlaceholder = 'Сообщение',
    String sendButtonAccessibilityLabel = 'Отправить',
    String today = 'Сегодня',
    String yesterday = 'Вчера',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
        );
}

/// Ukrainian l10n which extends [ChatL10n]
@immutable
class ChatL10nUk extends ChatL10n {
  /// Creates Ukrainian l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nUk({
    String attachmentButtonAccessibilityLabel = 'Надіслати медіа',
    String emptyChatPlaceholder = 'Повідомлень ще немає',
    String fileButtonAccessibilityLabel = 'Файл',
    String inputPlaceholder = 'Повідомлення',
    String sendButtonAccessibilityLabel = 'Надіслати',
    String today = 'Сьогодні',
    String yesterday = 'Учора',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
        );
}
