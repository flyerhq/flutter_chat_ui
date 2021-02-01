import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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

  void _openFile(types.FileMessage message) async {
    final client = new http.Client();
    var request = await client.get(Uri.parse(message.url));
    var bytes = request.bodyBytes;
    final documantsDir = (await getApplicationDocumentsDirectory()).path;
    final localPath = '$documantsDir/${message.fileName}';

    if (!File(localPath).existsSync()) {
      final file = new File(localPath);
      await file.writeAsBytes(bytes);
    }

    await OpenFile.open(localPath);
  }

  void _showFilePicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      File file = File(result.files.single.path);
      print(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  void _showImagePicker() async {
    final result = await ImagePicker().getImage(source: ImageSource.gallery);
    if (result != null) {
      File file = File(result.path);
      print(result.path);
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
        onSendPressed: (message) {
          setState(() {
            _messages.insert(0, message);
          });
        },
        user: const types.User(
          firstName: 'Alex',
          id: '06c33e8b-e835-4736-80f4-63f44b66666c',
          lastName: 'Demchenko',
        ),
      ),
    );
  }
}
