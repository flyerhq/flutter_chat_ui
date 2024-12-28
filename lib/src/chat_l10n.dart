import 'package:flutter/material.dart';

/// Base chat l10n containing all required properties to provide localized copy.
/// Extend this class if you want to create a custom l10n.
@immutable
abstract class ChatL10n {
  /// Creates a new chat l10n based on provided copy.
  const ChatL10n({
    required this.and,
    required this.attachmentButtonAccessibilityLabel,
    required this.emptyChatPlaceholder,
    required this.fileButtonAccessibilityLabel,
    required this.inputPlaceholder,
    required this.isTyping,
    required this.others,
    required this.sendButtonAccessibilityLabel,
    required this.unreadMessagesLabel,
  });

  /// Word 'and', currently part of the typing indicator.
  final String and;

  /// Accessibility label (hint) for the attachment button.
  final String attachmentButtonAccessibilityLabel;

  /// Placeholder when there are no messages.
  final String emptyChatPlaceholder;

  /// Accessibility label (hint) for the tap action on file message.
  final String fileButtonAccessibilityLabel;

  /// Placeholder for the text field.
  final String inputPlaceholder;

  /// Label for the typing indicator.
  final String isTyping;

  /// Word 'others', currently part of the typing indicator.
  final String others;

  /// Accessibility label (hint) for the send button.
  final String sendButtonAccessibilityLabel;

  /// Label for the unread messages header.
  final String unreadMessagesLabel;
}

/// Arabic l10n which extends [ChatL10n].
@immutable
class ChatL10nAr extends ChatL10n {
  /// Creates Arabic l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nAr({
    super.and = 'و',
    super.attachmentButtonAccessibilityLabel = 'إرسال الوسائط',
    super.emptyChatPlaceholder = 'لا يوجد رسائل هنا بعد',
    super.fileButtonAccessibilityLabel = 'ملف',
    super.inputPlaceholder = 'الرسالة',
    super.isTyping = 'يكتب…',
    super.others = 'آخرون',
    super.sendButtonAccessibilityLabel = 'إرسال',
    super.unreadMessagesLabel = 'الرسائل غير المقروءة',
  });
}

/// German l10n which extends [ChatL10n].
@immutable
class ChatL10nDe extends ChatL10n {
  /// Creates German l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nDe({
    super.and = 'und',
    super.attachmentButtonAccessibilityLabel = 'Medien senden',
    super.emptyChatPlaceholder = 'Noch keine Nachrichten',
    super.fileButtonAccessibilityLabel = 'Datei',
    super.inputPlaceholder = 'Nachricht',
    super.isTyping = 'tippt...',
    super.others = 'andere',
    super.sendButtonAccessibilityLabel = 'Senden',
    super.unreadMessagesLabel = 'Ungelesene Nachrichten',
  });
}

/// English l10n which extends [ChatL10n].
@immutable
class ChatL10nEn extends ChatL10n {
  /// Creates English l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nEn({
    super.and = 'and',
    super.attachmentButtonAccessibilityLabel = 'Send media',
    super.emptyChatPlaceholder = 'No messages here yet',
    super.fileButtonAccessibilityLabel = 'File',
    super.inputPlaceholder = 'Type your message',
    super.isTyping = 'is typing...',
    super.others = 'others',
    super.sendButtonAccessibilityLabel = 'Send',
    super.unreadMessagesLabel = 'Unread messages',
  });
}

/// Spanish l10n which extends [ChatL10n].
@immutable
class ChatL10nEs extends ChatL10n {
  /// Creates Spanish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nEs({
    super.and = 'y',
    super.attachmentButtonAccessibilityLabel = 'Enviar multimedia',
    super.emptyChatPlaceholder = 'Aún no hay mensajes',
    super.fileButtonAccessibilityLabel = 'Archivo',
    super.inputPlaceholder = 'Mensaje',
    super.isTyping = 'está escribiendo...',
    super.others = 'otros',
    super.sendButtonAccessibilityLabel = 'Enviar',
    super.unreadMessagesLabel = 'Mensajes no leídos',
  });
}

/// Persian l10n which extends [ChatL10n].
@immutable
class ChatL10nFa extends ChatL10n {
  const ChatL10nFa({
    super.and = 'و',
    super.attachmentButtonAccessibilityLabel = 'ارسال رسانه',
    super.emptyChatPlaceholder = 'هنوز پیامی در اینجا وجود ندارد',
    super.fileButtonAccessibilityLabel = 'فایل',
    super.inputPlaceholder = 'پیام',
    super.isTyping = 'در حال نوشتن است...',
    super.others = 'نفر دیگر',
    super.sendButtonAccessibilityLabel = 'ارسال',
    super.unreadMessagesLabel = 'پیام‌های خوانده نشده',
  });
}

/// Finnish l10n which extends [ChatL10n].
@immutable
class ChatL10nFi extends ChatL10n {
  /// Creates Finnish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nFi({
    super.and = 'ja',
    super.attachmentButtonAccessibilityLabel = 'Lähetä media',
    super.emptyChatPlaceholder = 'Täällä ei ole vielä viestejä',
    super.fileButtonAccessibilityLabel = 'Tiedosto',
    super.inputPlaceholder = 'Viesti',
    super.isTyping = 'kirjoittaa...',
    super.others = 'muuta',
    super.sendButtonAccessibilityLabel = 'Lähetä',
    super.unreadMessagesLabel = 'Lukemattomat viestit',
  });
}

/// Korean l10n which extends [ChatL10n].
@immutable
class ChatL10nKo extends ChatL10n {
  /// Creates Korean l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nKo({
    super.and = '및',
    super.attachmentButtonAccessibilityLabel = '미디어 보내기',
    super.emptyChatPlaceholder = '주고받은 메시지가 없습니다',
    super.fileButtonAccessibilityLabel = '파일',
    super.inputPlaceholder = '메시지',
    super.isTyping = '님이 입력 중...',
    super.others = '개',
    super.sendButtonAccessibilityLabel = '보내기',
    super.unreadMessagesLabel = '읽지 않은 메시지',
  });
}

/// Polish l10n which extends [ChatL10n].
@immutable
class ChatL10nPl extends ChatL10n {
  /// Creates Polish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nPl({
    super.and = 'i',
    super.attachmentButtonAccessibilityLabel = 'Wyślij multimedia',
    super.emptyChatPlaceholder = 'Tu jeszcze nie ma wiadomości',
    super.fileButtonAccessibilityLabel = 'Plik',
    super.inputPlaceholder = 'Napisz wiadomość',
    super.isTyping = 'pisze...',
    super.others = 'innych',
    super.sendButtonAccessibilityLabel = 'Wyślij',
    super.unreadMessagesLabel = 'Nieprzeczytane wiadomości',
  });
}

/// Portuguese l10n which extends [ChatL10n].
@immutable
class ChatL10nPt extends ChatL10n {
  /// Creates Portuguese l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nPt({
    super.and = 'e',
    super.attachmentButtonAccessibilityLabel = 'Envia mídia',
    super.emptyChatPlaceholder = 'Ainda não há mensagens aqui',
    super.fileButtonAccessibilityLabel = 'Arquivo',
    super.inputPlaceholder = 'Mensagem',
    super.isTyping = 'está a escrever...',
    super.others = 'outros',
    super.sendButtonAccessibilityLabel = 'Enviar',
    super.unreadMessagesLabel = 'Mensagens não lidas',
  });
}

/// Russian l10n which extends [ChatL10n].
@immutable
class ChatL10nRu extends ChatL10n {
  /// Creates Russian l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nRu({
    super.and = 'и',
    super.attachmentButtonAccessibilityLabel = 'Отправить медиа',
    super.emptyChatPlaceholder = 'Пока что у вас нет сообщений',
    super.fileButtonAccessibilityLabel = 'Файл',
    super.inputPlaceholder = 'Сообщение',
    super.isTyping = 'печатает…',
    super.others = 'другиx',
    super.sendButtonAccessibilityLabel = 'Отправить',
    super.unreadMessagesLabel = 'Непрочитанные сообщения',
  });
}

/// Swedish l10n which extends [ChatL10n].
@immutable
class ChatL10nSe extends ChatL10n {
  /// Creates Swedish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nSe({
    super.and = 'och',
    super.attachmentButtonAccessibilityLabel = 'Skicka media',
    super.emptyChatPlaceholder = 'Inga meddelanden än',
    super.fileButtonAccessibilityLabel = 'Fil',
    super.inputPlaceholder = 'Meddelande',
    super.isTyping = 'skriver...',
    super.others = 'andra',
    super.sendButtonAccessibilityLabel = 'Skicka',
    super.unreadMessagesLabel = 'Olästa meddelanden',
  });
}

/// Turkish l10n which extends [ChatL10n].
@immutable
class ChatL10nTr extends ChatL10n {
  /// Creates Turkish l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nTr({
    super.and = 've',
    super.attachmentButtonAccessibilityLabel = 'Medya gönder',
    super.emptyChatPlaceholder = 'Henüz mesaj yok',
    super.fileButtonAccessibilityLabel = 'Dosya',
    super.inputPlaceholder = 'Mesaj yazın',
    super.isTyping = 'yazıyor…',
    super.others = 'diğer kişi',
    super.sendButtonAccessibilityLabel = 'Gönder',
    super.unreadMessagesLabel = 'Okunmamış Mesajlar',
  });
}

/// Ukrainian l10n which extends [ChatL10n].
@immutable
class ChatL10nUk extends ChatL10n {
  /// Creates Ukrainian l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nUk({
    super.and = 'та ще',
    super.attachmentButtonAccessibilityLabel = 'Надіслати медіа',
    super.emptyChatPlaceholder = 'Повідомлень ще немає',
    super.fileButtonAccessibilityLabel = 'Файл',
    super.inputPlaceholder = 'Повідомлення',
    super.isTyping = 'пише...',
    super.others = 'інших',
    super.sendButtonAccessibilityLabel = 'Надіслати',
    super.unreadMessagesLabel = 'Непрочитанi повідомлення',
  });
}

/// Simplified Chinese l10n which extends [ChatL10n].
@immutable
class ChatL10nZhCN extends ChatL10n {
  /// Creates Simplified Chinese l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nZhCN({
    super.and = '和其他',
    super.attachmentButtonAccessibilityLabel = '发送媒体文件',
    super.emptyChatPlaceholder = '暂无消息',
    super.fileButtonAccessibilityLabel = '文件',
    super.inputPlaceholder = '输入消息',
    super.isTyping = '正在输入…',
    super.others = '人',
    super.sendButtonAccessibilityLabel = '发送',
    super.unreadMessagesLabel = '未读消息',
  });
}

/// Traditional Chinese l10n which extends [ChatL10n].
@immutable
class ChatL10nZhTW extends ChatL10n {
  /// Creates Traditional Chinese l10n. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatL10n].
  const ChatL10nZhTW({
    super.and = '和另外',
    super.attachmentButtonAccessibilityLabel = '傳送媒體',
    super.emptyChatPlaceholder = '還沒有訊息在這裡',
    super.fileButtonAccessibilityLabel = '檔案',
    super.inputPlaceholder = '輸入訊息',
    super.isTyping = '正在輸入…',
    super.others = '人',
    super.sendButtonAccessibilityLabel = '傳送',
    super.unreadMessagesLabel = '未讀訊息',
  });

  /// French l10n which extends [ChatL10n].
  @immutable
  class ChatL10nFr extends ChatL10n {
    /// Creates French l10n. Use this constructor if you want to
    /// override only a couple of properties, otherwise create a new class
    /// which extends [ChatL10n].
    const ChatL10nFr({
      super.and = 'et',
      super.attachmentButtonAccessibilityLabel = 'Envoyer des médias',
      super.emptyChatPlaceholder = 'Aucun message ici pour l\'instant',
      super.fileButtonAccessibilityLabel = 'Fichier',
      super.inputPlaceholder = 'Entrez votre message',
      super.isTyping = 'est en train d\'écrire...',
      super.others = 'autres',
      super.sendButtonAccessibilityLabel = 'Envoyer',
      super.unreadMessagesLabel = 'Messages non lus',
    });
  }   
}
