import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:sembast/sembast.dart';

import 'api.dart';
import 'api_get_initial_messages.dart';
import 'gemini.dart';
import 'initialize/initialize.dart';
import 'local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initialize();
  runApp(FlyerChat(database: database));
}

class FlyerChat extends StatelessWidget {
  final Database database;

  const FlyerChat({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flyer Chat',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      home: FlyerChatHomePage(database: database),
    );
  }
}

class FlyerChatHomePage extends StatefulWidget {
  final Database database;

  const FlyerChatHomePage({super.key, required this.database});

  @override
  State<FlyerChatHomePage> createState() => _FlyerChatHomePageState();
}

class _FlyerChatHomePageState extends State<FlyerChatHomePage> {
  final _dio = Dio();
  User _author = const User(id: 'sender1');
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _dio.close(force: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton<String>(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'sender1',
                  label: Text('sender1'),
                ),
                ButtonSegment<String>(
                  value: 'sender2',
                  label: Text('sender2'),
                ),
              ],
              selected: <String>{_author.id},
              onSelectionChanged: (Set<String> newSender) {
                setState(() {
                  // By default there is only a single segment that can be
                  // selected at one time, so its value is always the first
                  // item in the selected set.
                  _author = User(id: newSender.first);
                });
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'chat id',
                  border: OutlineInputBorder(),
                ),
                controller: _controller,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                getInitialMessages(_dio, chatId: _controller.text)
                    .then((messages) {
                  if (mounted && context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Api(
                          author: _author,
                          chatId: _controller.text,
                          initialMessages: messages,
                          dio: _dio,
                        ),
                      ),
                    );
                  }
                }).catchError((error) {
                  if (mounted && context.mounted) {
                    debugPrint(error.toString());
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                            'Make sure the chat ID is correct',
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              },
              child: const Text('api'),
            ),
            const SizedBox(
              width: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Local(author: _author, dio: _dio),
                  ),
                );
              },
              child: const Text('local'),
            ),
            const SizedBox(
              width: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Gemini(database: widget.database),
                  ),
                );
              },
              child: const Text('gemini'),
            ),
          ],
        ),
      ),
    );
  }
}
