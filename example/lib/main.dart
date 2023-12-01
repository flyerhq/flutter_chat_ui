import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:uuid/uuid.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChatPage(),
      );
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  types.Message? repliedMessage;
  final AutoScrollController scrollController = AutoScrollController();

  List<types.Message> _messages = [];
  final _user = const types.User(
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
      firstName: 'yesdevasdasdasdasdasdasdasd123123');

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        repliedMessage: repliedMessage,
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
        showStatus: true,
        status: types.Status.sent,
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
      repliedMessage: repliedMessage,
      showStatus: true,
      status: types.Status.sent,
    );
    repliedMessage = null;
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/6020066?v=4'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Yesdev'),
                  Text(
                    '@yes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz_outlined),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Chat(
            scrollController: scrollController,
            lastMessageId: "64747b28-df19-4a0c-8c47-316dc3546e3c",
            repliedMessageWidget: (repliedMessage != null)
                ? Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                              color: Colors.grey.shade900,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: (repliedMessage is types.TextMessage)
                                        ? TextMessage(
                                            message: repliedMessage!
                                                as types.TextMessage,
                                            emojiEnlargementBehavior:
                                                EmojiEnlargementBehavior.never,
                                            hideBackgroundOnEmojiMessages: true,
                                            showName: true,
                                            usePreviewData: false,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: TextMessage(
                                                  emojiEnlargementBehavior:
                                                      EmojiEnlargementBehavior
                                                          .never,
                                                  message: types.TextMessage(
                                                      author: repliedMessage!
                                                          .author,
                                                      id: repliedMessage?.id ??
                                                          '',
                                                      text: 'Fotoğraf'),
                                                  hideBackgroundOnEmojiMessages:
                                                      true,
                                                  showName: true,
                                                  usePreviewData: false,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              ImageMessage(
                                                message: types.ImageMessage(
                                                  size: 50,
                                                  author:
                                                      repliedMessage!.author,
                                                  id: repliedMessage!.id,
                                                  uri: (repliedMessage!
                                                          as types.ImageMessage)
                                                      .uri,
                                                  name: 'Fotoğraf',
                                                ),
                                                messageWidth: 50,
                                                minWidth: 50,
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        repliedMessage = null;
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white.withOpacity(0.5),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
            theme: DarkChatTheme(
              messageInsetsVertical: 10,
              messageInsetsHorizontal: 10,
              backgroundColor: Colors.black,
              messageBorderRadius: 20,
              primaryColor: Colors.lightBlue,
              secondaryColor: const Color(0xff323639),
              receivedRepliedMessageBackgroundColor: const Color(0xff17181C),
              attachmentButtonIcon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
              ),
              inputPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              inputMargin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              inputContainerDecoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            messages: _messages,
            onSwipeToRight: (context, message) {
              if (repliedMessage != null) {
                setState(() {
                  repliedMessage = null;
                });
              }
              setState(() {
                if (message is types.TextMessage) {
                  repliedMessage = types.TextMessage(
                      author: message.author,
                      id: message.id,
                      text: (message).text);
                } else if (message is types.ImageMessage) {
                  repliedMessage = types.ImageMessage(
                    size: 50,
                    uri: message.uri,
                    author: message.author,
                    id: message.id,
                    name: 'Fotoğraf',
                  );
                }
              });
            },
            onMessageLongPress: (context, message) {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          final index = _messages.indexWhere(
                              (element) => element.id == message.id);

                          final updatedMessage =
                              (_messages[index] as types.TextMessage).copyWith(
                            text: 'Deleted',
                          );

                          setState(() {
                            _messages[index] = updatedMessage;
                          });
                        },
                        child: const Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text('Delete'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            repliedMessage = types.TextMessage(
                                author: message.author,
                                id: message.id,
                                text: (message as types.TextMessage).text);
                          });
                        },
                        child: const Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text('Yanıtla'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onAttachmentPressed: _handleAttachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            showUserAvatars: false,
            showUserNames: false,
            user: _user,
          ),
        ),
      );
}
