import 'package:flutter/material.dart';

/// Base chat l10n containing all required properties to provide localized copy.
/// Extend this class if you want to create a custom l10n.
@immutable
abstract class ChatL10n {
  /// Creates a new chat l10n based on provided copy.
  const ChatL10n({
    required this.attachmentButtonAccessibilityLabel,
    required this.emptyChatPlaceholder,
    required this.fileButtonAccessibilityLabel,
    required this.inputPlaceholder,
    required this.sendButtonAccessibilityLabel,
  });

  /// Accessibility label (hint) for the attachment button.
  final String attachmentButtonAccessibilityLabel;

  /// Placeholder when there are no messages.
  final String emptyChatPlaceholder;

  /// Accessibility label (hint) for the tap action on file message.
  final String fileButtonAccessibilityLabel;

  /// Placeholder for the text field.
  final String inputPlaceholder;

  /// Accessibility label (hint) for the send button.
  final String sendButtonAccessibilityLabel;
}

/// Arabic l10n which extends [ChatL10n].
@immutable
class ChatL10nAr extends ChatL10n {
  /// Creates Arabic l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nAr({
    super.attachmentButtonAccessibilityLabel = 'إرسال الوسائط',
    super.emptyChatPlaceholder = 'لا يوجد رسائل هنا بعد',
    super.fileButtonAccessibilityLabel = 'ملف',
    super.inputPlaceholder = 'الرسالة',
    super.sendButtonAccessibilityLabel = 'إرسال',
  });
}

/// German l10n which extends [ChatL10n].
@immutable
class ChatL10nDe extends ChatL10n {
  /// Creates German l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nDe({
    super.attachmentButtonAccessibilityLabel = 'Medien senden',
    super.emptyChatPlaceholder = 'Noch keine Nachrichten',
    super.fileButtonAccessibilityLabel = 'Datei',
    super.inputPlaceholder = 'Nachricht',
    super.sendButtonAccessibilityLabel = 'Senden',
  });
}

/// English l10n which extends [ChatL10n].
@immutable
class ChatL10nEn extends ChatL10n {
  /// Creates English l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nEn({
    super.attachmentButtonAccessibilityLabel = 'Send media',
    super.emptyChatPlaceholder = 'No messages here yet',
    super.fileButtonAccessibilityLabel = 'File',
    super.inputPlaceholder = 'Message',
    super.sendButtonAccessibilityLabel = 'Send',
  });
}

/// Spanish l10n which extends [ChatL10n].
@immutable
class ChatL10nEs extends ChatL10n {
  /// Creates Spanish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nEs({
    super.attachmentButtonAccessibilityLabel = 'Enviar multimedia',
    super.emptyChatPlaceholder = 'Aún no hay mensajes',
    super.fileButtonAccessibilityLabel = 'Archivo',
    super.inputPlaceholder = 'Mensaje',
    super.sendButtonAccessibilityLabel = 'Enviar',
  });
}

/// Korean l10n which extends [ChatL10n].
@immutable
class ChatL10nKo extends ChatL10n {
  /// Creates Korean l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nKo({
    super.attachmentButtonAccessibilityLabel = '미디어 보내기',
    super.emptyChatPlaceholder = '주고받은 메시지가 없습니다',
    super.fileButtonAccessibilityLabel = '파일',
    super.inputPlaceholder = '메시지',
    super.sendButtonAccessibilityLabel = '보내기',
  });
}

/// Polish l10n which extends [ChatL10n].
@immutable
class ChatL10nPl extends ChatL10n {
  /// Creates Polish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nPl({
    super.attachmentButtonAccessibilityLabel = 'Wyślij multimedia',
    super.emptyChatPlaceholder = 'Tu jeszcze nie ma wiadomości',
    super.fileButtonAccessibilityLabel = 'Plik',
    super.inputPlaceholder = 'Napisz wiadomość',
    super.sendButtonAccessibilityLabel = 'Wyślij',
  });
}

/// Portuguese l10n which extends [ChatL10n].
@immutable
class ChatL10nPt extends ChatL10n {
  /// Creates Portuguese l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nPt({
    super.attachmentButtonAccessibilityLabel = 'Envia mídia',
    super.emptyChatPlaceholder = 'Ainda não há mensagens aqui',
    super.fileButtonAccessibilityLabel = 'Arquivo',
    super.inputPlaceholder = 'Mensagem',
    super.sendButtonAccessibilityLabel = 'Enviar',
  });
}

/// Russian l10n which extends [ChatL10n].
@immutable
class ChatL10nRu extends ChatL10n {
  /// Creates Russian l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nRu({
    super.attachmentButtonAccessibilityLabel = 'Отправить медиа',
    super.emptyChatPlaceholder = 'Пока что у вас нет сообщений',
    super.fileButtonAccessibilityLabel = 'Файл',
    super.inputPlaceholder = 'Сообщение',
    super.sendButtonAccessibilityLabel = 'Отправить',
  });
}

/// Turkish l10n which extends [ChatL10n].
@immutable
class ChatL10nTr extends ChatL10n {
  /// Creates Turkish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nTr({
    super.attachmentButtonAccessibilityLabel = 'Medya gönder',
    super.emptyChatPlaceholder = 'Henüz mesaj yok',
    super.fileButtonAccessibilityLabel = 'Dosya',
    super.inputPlaceholder = 'Mesaj yazın',
    super.sendButtonAccessibilityLabel = 'Gönder',
  });
}

/// Ukrainian l10n which extends [ChatL10n].
@immutable
class ChatL10nUk extends ChatL10n {
  /// Creates Ukrainian l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nUk({
    super.attachmentButtonAccessibilityLabel = 'Надіслати медіа',
    super.emptyChatPlaceholder = 'Повідомлень ще немає',
    super.fileButtonAccessibilityLabel = 'Файл',
    super.inputPlaceholder = 'Повідомлення',
    super.sendButtonAccessibilityLabel = 'Надіслати',
  });
}

/// Simplified Chinese l10n which extends [ChatL10n].
@immutable
class ChatL10nZhCN extends ChatL10n {
  /// Creates Simplified Chinese l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nZhCN({
    super.attachmentButtonAccessibilityLabel = '发送媒体文件',
    super.emptyChatPlaceholder = '暂无消息',
    super.fileButtonAccessibilityLabel = '文件',
    super.inputPlaceholder = '输入消息',
    super.sendButtonAccessibilityLabel = '发送',
  });
}

/// Traditional Chinese l10n which extends [ChatL10n].
@immutable
class ChatL10nZhTW extends ChatL10n {
  /// Creates Traditional Chinese l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nZhTW({
    super.attachmentButtonAccessibilityLabel = '傳送媒體',
    super.emptyChatPlaceholder = '還沒有訊息在這裡',
    super.fileButtonAccessibilityLabel = '檔案',
    super.inputPlaceholder = '輸入訊息',
    super.sendButtonAccessibilityLabel = '傳送',
  });
}
