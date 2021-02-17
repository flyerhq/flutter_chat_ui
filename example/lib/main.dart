import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];

  final _user = types.User(
    firstName: 'Alex',
    id: '06c33e8b-e835-4736-80f4-63f44b66666c',
    lastName: 'Demchenko',
  );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAtachmentPress() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showFilePicker();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Open file picker"),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showImagePicker();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Open image picker"),
                  )),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Cancel"),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  void _onPreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    types.TextMessage currentMessage = _messages[index];
    final updatedMessage = currentMessage.copyWith(previewData: previewData);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _onSendMessage(types.PartialText message) {
    final textMessage = types.TextMessage(
      authorId: _user.id,
      id: Uuid().v4(),
      text: message.text,
      timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
    );

    _addMessage(textMessage);
  }

  void _openFile(types.FileMessage message) async {
    String localPath = message.url;

    if (message.url.startsWith('http')) {
      final client = new http.Client();
      var request = await client.get(Uri.parse(message.url));
      var bytes = request.bodyBytes;
      final documentsDir = (await getApplicationDocumentsDirectory()).path;
      localPath = '$documentsDir/${message.fileName}';

      if (!File(localPath).existsSync()) {
        final file = new File(localPath);
        await file.writeAsBytes(bytes);
      }
    }

    await OpenFile.open(localPath);
  }

  void _showFilePicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      final message = types.FileMessage(
        authorId: _user.id,
        id: Uuid().v4(),
        fileName: result.files.single.name,
        mimeType: lookupMimeType(result.files.single.path),
        size: result.files.single.size,
        url: result.files.single.path,
        timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
      );

      _addMessage(message);
    } else {
      // User canceled the picker
    }
  }

  void _showImagePicker() async {
    final result = await ImagePicker().getImage(source: ImageSource.gallery);
    if (result != null) {
      final size = File(result.path).lengthSync();
      final extension = result.path.split('.').last;

      final message = types.ImageMessage(
        authorId: _user.id,
        id: Uuid().v4(),
        imageName: 'image.$extension',
        size: size,
        // As ImageMessage currently supports only NetworkImage passing url instead of result.path,
        url: 'https://i.ytimg.com/vi/L42-aFe8bMo/maxresdefault.jpg',
        timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
      );

      _addMessage(message);
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
        onAttachmentPressed: _handleAtachmentPress,
        onFilePressed: _openFile,
        onPreviewDataFetched: _onPreviewDataFetched,
        onSendPressed: _onSendMessage,
        user: _user,
      ),
    );
  }
}
